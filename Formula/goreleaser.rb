class Goreleaser < Formula
  desc "Deliver Go binaries as fast and easily as possible"
  homepage "https://goreleaser.com/"
  url "https://github.com/goreleaser/goreleaser.git",
      tag:      "v1.9.2",
      revision: "b869ea44b7e211c59d856307a5d308b594030218"
  license "MIT"
  head "https://github.com/goreleaser/goreleaser.git", branch: "main"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/goreleaser"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "df53756b3d12dbb90af07a64474d45e9a472b8c2513490ede4f2231cb8b19808"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.commit=#{Utils.git_head}
      -X main.builtBy=homebrew
    ]

    system "go", "build", *std_go_args(ldflags: ldflags)

    # Install shell completions
    output = Utils.safe_popen_read("#{bin}/goreleaser", "completion", "bash")
    (bash_completion/"goreleaser").write output

    output = Utils.safe_popen_read("#{bin}/goreleaser", "completion", "zsh")
    (zsh_completion/"_goreleaser").write output

    output = Utils.safe_popen_read("#{bin}/goreleaser", "completion", "fish")
    (fish_completion/"goreleaser.fish").write output
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/goreleaser -v 2>&1")
    assert_match "config created", shell_output("#{bin}/goreleaser init --config=.goreleaser.yml 2>&1")
    assert_predicate testpath/".goreleaser.yml", :exist?
  end
end
