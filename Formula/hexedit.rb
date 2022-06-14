class Hexedit < Formula
  desc "View and edit files in hexadecimal or ASCII"
  homepage "http://rigaux.org/hexedit.html"
  url "https://github.com/pixel/hexedit/archive/1.6.tar.gz"
  sha256 "598906131934f88003a6a937fab10542686ce5f661134bc336053e978c4baae3"
  license "GPL-2.0-or-later"
  head "https://github.com/pixel/hexedit.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/hexedit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b3f612e0592ba989af3e9cf147c0bbab0fba6ca9d54b36d4abf0db5e1c4076b7"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  uses_from_macos "ncurses"

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    shell_output("#{bin}/hexedit -h 2>&1", 1)
  end
end
