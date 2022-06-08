class Nerdctl < Formula
  desc "ContaiNERD CTL - Docker-compatible CLI for containerd"
  homepage "https://github.com/containerd/nerdctl"
  url "https://github.com/containerd/nerdctl/archive/refs/tags/v0.20.0.tar.gz"
  sha256 "69c391d4074793ef2a2cb1b53a97a54b0c3bc4229914aa62b99495f9d5c0cdfa"
  license "Apache-2.0"
  head "https://github.com/containerd/nerdctl.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/nerdctl"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "6d985f4258888b7703f9ba89bd2ba6d00803990b5061663f17c6dfc251e9d7b8"
  end

  depends_on "go" => :build
  depends_on :linux

  def install
    ldflags = "-s -w -X github.com/containerd/nerdctl/pkg/version.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/nerdctl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nerdctl --version")
    output = shell_output("XDG_RUNTIME_DIR=/dev/null #{bin}/nerdctl images 2>&1", 1).strip
    cleaned = output.gsub(/\e\[([;\d]+)?m/, "") # Remove colors from output
    assert_match(/^time=.* level=fatal msg="rootless containerd not running.*/m, cleaned)
  end
end
