class Lazygit < Formula
  desc "Simple terminal UI for git commands"
  homepage "https://github.com/jesseduffield/lazygit/"
  url "https://github.com/jesseduffield/lazygit/archive/v0.34.tar.gz"
  sha256 "f715ab86b219fd42462399459bfa1e04a5925268bff4839c4d96bd01264d6847"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/lazygit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "6fd4e4026c5645134c601e776a3363d26638fa94ab24c4f26c1f4a6df34dbb6a"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-mod=vendor", "-o", bin/"lazygit",
      "-ldflags", "-X main.version=#{version} -X main.buildSource=homebrew"
  end

  # lazygit is a terminal GUI, but it can be run in 'client mode' for example to write to git's todo file
  test do
    (testpath/"git-rebase-todo").write ""
    ENV["LAZYGIT_CLIENT_COMMAND"] = "INTERACTIVE_REBASE"
    ENV["LAZYGIT_REBASE_TODO"] = "foo"
    system "#{bin}/lazygit", "git-rebase-todo"
    assert_match "foo", (testpath/"git-rebase-todo").read
  end
end
