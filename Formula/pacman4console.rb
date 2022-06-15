class Pacman4console < Formula
  desc "Pacman for console"
  homepage "https://sites.google.com/site/doctormike/pacman.html"
  url "https://ftp.debian.org/debian/pool/main/p/pacman4console/pacman4console_1.3.orig.tar.gz"
  sha256 "9a5c4a96395ce4a3b26a9896343a2cdf488182da1b96374a13bf5d811679eb90"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pacman4console"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "2408323e04821073b2333618f412ba41ad60138b0187913bd55ab4873192a5a0"
  end

  # The Google Sites website is no longer available.
  deprecate! date: "2021-10-23", because: :unmaintained

  uses_from_macos "ncurses"

  def install
    system "make", "prefix=#{prefix}", "datarootdir=#{pkgshare}"
    bin.install ["pacman", "pacmanedit"]
    (pkgshare+"pacman").install "Levels"
  end
end
