class GitTown < Formula
  desc "High-level command-line interface for Git"
  homepage "https://www.git-town.com/"
  url "https://github.com/git-town/git-town/archive/v7.7.0.tar.gz"
  sha256 "edc4f87ef904ac297b9fbb30014e2ab474ee633c1687ed5011b38cd6f8b950e2"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/git-town"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "14d7ee4aa46eba34b53098108db654f41865dcd5dde9f65991f8bbfa2dcc6c7f"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/git-town/git-town/v7/src/cmd.version=v#{version}
      -X github.com/git-town/git-town/v7/src/cmd.buildDate=#{time.strftime("%Y/%m/%d")}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags)

    # Install shell completions
    (bash_completion/"git-town").write Utils.safe_popen_read(bin/"git-town", "completions", "bash")
    (zsh_completion/"_git-town").write Utils.safe_popen_read(bin/"git-town", "completions", "zsh")
    (fish_completion/"git-town.fish").write Utils.safe_popen_read(bin/"git-town", "completions", "fish")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/git-town version")

    system "git", "init"
    touch "testing.txt"
    system "git", "add", "testing.txt"
    system "git", "commit", "-m", "Testing!"

    system bin/"git-town", "config"
  end
end
