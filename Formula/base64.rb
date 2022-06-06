class Base64 < Formula
  desc "Encode and decode base64 files"
  homepage "https://www.fourmilab.ch/webtools/base64/"
  url "https://www.fourmilab.ch/webtools/base64/base64-1.5.tar.gz"
  sha256 "2416578ba7a7197bddd1ee578a6d8872707c831d2419bdc2c1b4317a7e3c8a2a"

  livecheck do
    url :homepage
    regex(/href=.*?base64[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/base64"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "262c5f18d5223a47db1d3653c3a1175325636794725115139900e0b74d9b09ab"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking"
    system "make"
    bin.install "base64"
    man1.install "base64.1"
  end

  test do
    path = testpath/"a.txt"
    path.write "hello"
    assert_equal "aGVsbG8=", shell_output("#{bin}/base64 #{path}").strip
  end
end
