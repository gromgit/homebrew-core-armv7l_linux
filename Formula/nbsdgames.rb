class Nbsdgames < Formula
  desc "Text-based modern games"
  homepage "https://github.com/abakh/nbsdgames"
  url "https://github.com/abakh/nbsdgames/archive/refs/tags/v5.tar.gz"
  sha256 "ca81d8b854a7bf9685bbc58aabc1a24cd617cadb7e9ddac64a513d2c8ddb2e6c"
  license :public_domain
  head "https://github.com/abakh/nbsdgames.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/nbsdgames"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "39e958c44176716d3b41fbea2d6bb69cf5767b3fb68684235c045af2ab9c446c"
  end

  uses_from_macos "ncurses"

  def install
    mkdir bin
    system "make", "install",
           "GAMES_DIR=#{bin}",
           "SCORES_DIR=#{var}/games"

    mkdir man6
    system "make", "manpages", "MAN_DIR=#{man6}"
  end

  test do
    assert_equal "2 <= size <= 7", shell_output("#{bin}/sudoku -s 1", 1).chomp
  end
end
