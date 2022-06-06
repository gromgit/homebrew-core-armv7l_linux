class BrewCaskCompletion < Formula
  desc "Fish completion for brew-cask"
  homepage "https://github.com/xyb/homebrew-cask-completion"
  url "https://github.com/xyb/homebrew-cask-completion/archive/v2.1.tar.gz"
  sha256 "27c7ea3b7f7c060f5b5676a419220c4ce6ebf384237e859a61c346f61c8f7a1b"
  license "BSD-2-Clause"
  revision 1
  head "https://github.com/xyb/homebrew-cask-completion.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/brew-cask-completion"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e721cd8e1a962f4fd2008629ca6c2c10f70f8902525edbd84c878140e03b81a4"
  end

  def install
    fish_completion.install "brew-cask.fish"
  end

  test do
    assert_predicate fish_completion/"brew-cask.fish", :exist?
  end
end
