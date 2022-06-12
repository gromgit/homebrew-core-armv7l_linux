class F3 < Formula
  desc "Test various flash cards"
  homepage "https://fight-flash-fraud.readthedocs.io/en/latest/"
  url "https://github.com/AltraMayor/f3/archive/v8.0.tar.gz"
  sha256 "fb5e0f3b0e0b0bff2089a4ea6af53278804dfe0b87992499131445732e311ab4"
  license "GPL-3.0-only"
  head "https://github.com/AltraMayor/f3.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/f3"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "06edda6e47cc626ad4a340ebd49d703a2d6e8435be829aac1b8cc6534751cf25"
  end

  on_macos do
    depends_on "argp-standalone"
  end

  def install
    args = []
    args << "ARGP=#{Formula["argp-standalone"].opt_prefix}" if OS.mac?
    system "make", "all", *args
    bin.install %w[f3read f3write]
    man1.install "f3read.1"
    man1.install_symlink "f3read.1" => "f3write.1"
  end

  test do
    system "#{bin}/f3read", testpath
  end
end
