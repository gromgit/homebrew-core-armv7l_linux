class Pkger < Formula
  desc "Embed static files in Go binaries (replacement for gobuffalo/packr)"
  homepage "https://github.com/markbates/pkger"
  url "https://github.com/markbates/pkger/archive/v0.17.1.tar.gz"
  sha256 "da775b5ec5675f0db75cf295ff07a4a034ba15eb5cc02d278a5767f387fb8273"
  license "MIT"
  head "https://github.com/markbates/pkger.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pkger"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "56edd594bed7642acab134ff558edb43c0b01fce5453839cb4df19145fbda519"
  end

  depends_on "go"

  def install
    system "go", "build", *std_go_args, "./cmd/pkger"
  end

  test do
    mkdir "test" do
      system "go", "mod", "init", "example.com"
      system bin/"pkger"
      assert_predicate testpath/"test/pkged.go", :exist?
      assert_equal "{\n \".\": null\n}\n", shell_output("#{bin}/pkger parse")
    end
  end
end
