class Qodem < Formula
  desc "Terminal emulator and BBS client"
  homepage "https://qodem.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/qodem/qodem/1.0.1/qodem-1.0.1.tar.gz"
  sha256 "dedc73bfa73ced5c6193f1baf1ffe91f7accaad55a749240db326cebb9323359"
  license :public_domain

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/qodem"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "659b25c57f01ae828a072249ce5f7eac4cd0b1ae4dc3e6a66533e5f86e6ea4d6"
  end

  deprecate! date: "2022-05-07", because: :repo_removed

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  uses_from_macos "ncurses"

  def install
    system "./configure", *std_configure_args,
                          "--disable-silent-rules",
                          "--disable-gpm",
                          "--disable-sdl",
                          "--disable-serial",
                          "--disable-upnp",
                          "--disable-x11"
    system "make", "install"
  end

  test do
    system "#{bin}/qodem", "--exit-on-completion", "--capfile", testpath/"qodem.out", "uname"
    assert_match OS.kernel_name, File.read(testpath/"qodem.out")
  end
end
