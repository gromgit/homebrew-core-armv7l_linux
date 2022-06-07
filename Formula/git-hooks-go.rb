class GitHooksGo < Formula
  desc "Git hooks manager"
  homepage "https://git-hooks.github.io/git-hooks"
  url "https://github.com/git-hooks/git-hooks/archive/v1.3.1.tar.gz"
  sha256 "c37cedf52b3ea267b7d3de67dde31adad4d2a22a7780950d6ca2da64a8b0341b"
  license "MIT"
  head "https://github.com/git-hooks/git-hooks.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/git-hooks-go"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "4b220f2fcee0e1e6599e9890dbb4afe3daef7b3deb6b93235c18379ed1ca89b3"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"git-hooks")
  end

  test do
    system "git", "init"
    system "git", "hooks", "install"
    assert_match "Git hooks ARE installed in this repository.", shell_output("git hooks")
  end
end
