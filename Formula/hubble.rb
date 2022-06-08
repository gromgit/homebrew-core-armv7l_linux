class Hubble < Formula
  desc "Network, Service & Security Observability for Kubernetes using eBPF"
  homepage "https://github.com/cilium/hubble"
  url "https://github.com/cilium/hubble/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "4de209eb1cb54eb764efd4569b2fa59a4a92ef5c86055eff90805dad7a0dde6f"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/hubble"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f070da728a4bc06c23af19f61651f1857fcc1264b129f4758197c4893eec8163"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/cilium/hubble/pkg.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags)

    bash_output = Utils.safe_popen_read(bin/"hubble", "completion", "bash")
    (bash_completion/"hubble").write bash_output
    zsh_output = Utils.safe_popen_read(bin/"hubble", "completion", "zsh")
    (zsh_completion/"_hubble").write zsh_output
    fish_output = Utils.safe_popen_read(bin/"hubble", "completion", "fish")
    (fish_completion/"hubble.fish").write fish_output
  end

  test do
    assert_match(/tls-allow-insecure:/, shell_output("#{bin}/hubble config get"))
  end
end
