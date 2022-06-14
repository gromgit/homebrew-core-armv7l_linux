class GnuGo < Formula
  desc "Plays the game of Go"
  homepage "https://www.gnu.org/software/gnugo/gnugo.html"
  url "https://ftp.gnu.org/gnu/gnugo/gnugo-3.8.tar.gz"
  mirror "https://ftpmirror.gnu.org/gnugo/gnugo-3.8.tar.gz"
  sha256 "da68d7a65f44dcf6ce6e4e630b6f6dd9897249d34425920bfdd4e07ff1866a72"
  revision 1
  head "https://git.savannah.gnu.org/git/gnugo.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gnu-go"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "df718a2a42b0e0ca86472b83bb594876c5ab0d50bcf5f41896b07c8158be312d"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-readline"
    system "make", "install"
  end

  test do
    assert_match(/GNU Go #{version}$/, shell_output("#{bin}/gnugo --version"))
  end
end
