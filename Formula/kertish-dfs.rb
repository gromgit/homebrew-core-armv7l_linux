class KertishDfs < Formula
  desc "Kertish FileSystem and Cluster Administration CLI"
  homepage "https://github.com/freakmaxi/kertish-dfs"
  url "https://github.com/freakmaxi/kertish-dfs/archive/v22.2.0147.tar.gz"
  version "22.2.0147-532592"
  sha256 "a13d55b3f48ed0e16b1add3a44587072b22d21a9f95c444893dbf92e19ee5cee"
  license "GPL-3.0-only"
  head "https://github.com/freakmaxi/kertish-dfs.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/kertish-dfs"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b65510acd0b33548b2cc79c121f73fdef1930028961c1899a88ecf1614319414"
  end

  depends_on "go" => :build

  def install
    cd "fs-tool" do
      system "go", "build", *std_go_args(output: bin/"krtfs", ldflags: "-X main.version=#{version}")
    end
    cd "admin-tool" do
      system "go", "build", *std_go_args(output: bin/"krtadm", ldflags: "-X main.version=#{version}")
    end
  end

  test do
    port = free_port
    assert_match("failed.\nlocalhost:#{port}: head node is not reachable",
      shell_output("#{bin}/krtfs -t localhost:#{port} ls"))
    assert_match("localhost:#{port}: manager node is not reachable",
      shell_output("#{bin}/krtadm -t localhost:#{port} -get-clusters", 70))
  end
end
