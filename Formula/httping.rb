class Httping < Formula
  desc "Ping-like tool for HTTP requests"
  homepage "https://www.vanheusden.com/httping/"
  url "https://www.mirrorservice.org/sites/distfiles.macports.org/httping/httping-2.5.tgz"
  mirror "https://fossies.org/linux/www/httping-2.5.tgz"
  sha256 "3e895a0a6d7bd79de25a255a1376d4da88eb09c34efdd0476ab5a907e75bfaf8"
  license "GPL-2.0"
  revision 2

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/httping"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b7333ebdd83a0b295e0346f18e5c8bf473db08200e2ab2ac9df6429be590b91c"
  end

  deprecate! date: "2021-05-20", because: :repo_removed

  depends_on "gettext"
  depends_on "openssl@1.1"

  uses_from_macos "ncurses"

  def install
    # Reported upstream, see: https://github.com/Homebrew/homebrew/pull/28653
    inreplace %w[configure Makefile], "ncursesw", "ncurses"
    ENV.append "LDFLAGS", "-lintl" if OS.mac?
    inreplace "Makefile", "cp nl.mo $(DESTDIR)/$(PREFIX)/share/locale/nl/LC_MESSAGES/httping.mo", ""
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"httping", "-c", "2", "-g", "https://brew.sh/"
  end
end
