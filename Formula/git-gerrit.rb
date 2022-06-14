class GitGerrit < Formula
  desc "Gerrit code review helper scripts"
  homepage "https://github.com/fbzhong/git-gerrit"
  url "https://github.com/fbzhong/git-gerrit/archive/v0.3.0.tar.gz"
  sha256 "433185315db3367fef82a7332c335c1c5e0b05dabf8d4fbeff9ecf6cc7e422eb"
  license "BSD-3-Clause"
  head "https://github.com/fbzhong/git-gerrit.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/git-gerrit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f787bba2e4465a7f5df3bebcdb625c3815331a721abc0024ab09b14b868b3ec5"
  end

  def install
    prefix.install "bin"
    bash_completion.install "completion/git-gerrit-completion.bash"
  end

  test do
    system "git", "init"
    system "git", "gerrit", "help"
  end
end
