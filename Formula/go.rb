class Go < Formula
  desc "Open source programming language to build simple/reliable/efficient software"
  homepage "https://go.dev/"
  url "https://go.dev/dl/go1.18.3.src.tar.gz"
  mirror "https://fossies.org/linux/misc/go1.18.3.src.tar.gz"
  sha256 "0012386ddcbb5f3350e407c679923811dbd283fcdc421724931614a842ecbc2d"
  license "BSD-3-Clause"
  head "https://go.googlesource.com/go.git", branch: "master"

  livecheck do
    url "https://go.dev/dl/"
    regex(/href=.*?go[._-]?v?(\d+(?:\.\d+)+)[._-]src\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/go"
    sha256 armv7l_linux: "cc91a6a70ea53c04d24a7fc96cd1e8252ac190b7e266c2fb89d028d76be9d2fe"
  end

  # Don't update this unless this version cannot bootstrap the new version.
  resource "gobootstrap" do
    on_macos do
      if Hardware::CPU.arm?
        url "https://storage.googleapis.com/golang/go1.16.darwin-arm64.tar.gz"
        sha256 "4dac57c00168d30bbd02d95131d5de9ca88e04f2c5a29a404576f30ae9b54810"
      else
        url "https://storage.googleapis.com/golang/go1.16.darwin-amd64.tar.gz"
        sha256 "6000a9522975d116bf76044967d7e69e04e982e9625330d9a539a8b45395f9a8"
      end
    end

    on_linux do
      if Hardware::CPU.arm?
        if Hardware::CPU.bits == 32
          url "https://storage.googleapis.com/golang/go1.16.linux-armv6l.tar.gz"
          sha256 "d1d9404b1dbd77afa2bdc70934e10fbfcf7d785c372efc29462bb7d83d0a32fd"
        else
          url "https://storage.googleapis.com/golang/go1.16.linux-arm64.tar.gz"
          sha256 "3770f7eb22d05e25fbee8fb53c2a4e897da043eb83c69b9a14f8d98562cd8098"
        end
      else
        url "https://storage.googleapis.com/golang/go1.16.linux-amd64.tar.gz"
        sha256 "013a489ebb3e24ef3d915abe5b94c3286c070dfe0818d5bca8108f1d6e8440d2"
      end
    end
  end

  def install
    (buildpath/"gobootstrap").install resource("gobootstrap")
    ENV["GOROOT_BOOTSTRAP"] = buildpath/"gobootstrap"

    cd "src" do
      ENV["GOROOT_FINAL"] = libexec
      system "./make.bash", "--no-clean"
    end

    (buildpath/"pkg/obj").rmtree
    rm_rf "gobootstrap" # Bootstrap not required beyond compile.
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/go*"]

    build_opts = []
    if Hardware::CPU.bits > 32
      build_opts += ["-race"]
    end
    system bin/"go", "install", *build_opts, "std"

    # Remove useless files.
    # Breaks patchelf because folder contains weird debug/test files
    (libexec/"src/debug/elf/testdata").rmtree
    (libexec/"src/debug/dwarf/testdata").rmtree
    # Binaries built for an incompatible architecture
    (libexec/"src/runtime/pprof/testdata").rmtree
  end

  test do
    (testpath/"hello.go").write <<~EOS
      package main

      import "fmt"

      func main() {
          fmt.Println("Hello World")
      }
    EOS
    # Run go fmt check for no errors then run the program.
    # This is a a bare minimum of go working as it uses fmt, build, and run.
    system bin/"go", "fmt", "hello.go"
    assert_equal "Hello World\n", shell_output("#{bin}/go run hello.go")

    ENV["GOOS"] = "freebsd"
    ENV["GOARCH"] = "amd64"
    system bin/"go", "build", "hello.go"
  end
end
