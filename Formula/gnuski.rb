class Gnuski < Formula
  desc "Open source clone of Skifree"
  homepage "https://gnuski.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/gnuski/gnuski/gnuski-0.3/gnuski-0.3.tar.gz"
  sha256 "1b629bd29dd6ad362b56055ccdb4c7ad462ff39d7a0deb915753c2096f5f959d"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gnuski"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1a87a65f59b4c53f9abbf7d31046540c961b4ee4c03c2ee6925e5dcf4a9001fa"
  end

  uses_from_macos "ncurses"

  def install
    system "make"
    bin.install "gnuski"
  end
end
