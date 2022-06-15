class Mdp < Formula
  desc "Command-line based markdown presentation tool"
  homepage "https://github.com/visit1985/mdp"
  url "https://github.com/visit1985/mdp/archive/1.0.15.tar.gz"
  sha256 "3edc8ea1551fdf290d6bba721105e2e2c23964070ac18c13b4b8d959cdf6116f"
  license "GPL-3.0"
  head "https://github.com/visit1985/mdp.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mdp"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "50db1301e86e664b7d9c085fdb2dd55bb0601f3f0b74073bed720d2cf676fd5d"
  end

  uses_from_macos "ncurses"

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
    pkgshare.install "sample.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mdp -v")
  end
end
