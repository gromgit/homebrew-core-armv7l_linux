class Cronolog < Formula
  desc "Web log rotation"
  homepage "https://web.archive.org/web/20140209202032/cronolog.org/"
  url "https://www.mirrorservice.org/sites/distfiles.macports.org/cronolog/cronolog-1.6.2.tar.gz"
  mirror "https://fossies.org/linux/www/old/cronolog-1.6.2.tar.gz"
  sha256 "65e91607643e5aa5b336f17636fa474eb6669acc89288e72feb2f54a27edb88e"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cronolog"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b3a4563178f46a2910d28a559262fe288bc9f85f0174e443fb6fee8b1c22c84b"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}"
    system "make", "install"
  end
end
