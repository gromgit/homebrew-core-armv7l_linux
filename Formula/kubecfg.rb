class Kubecfg < Formula
  desc "Manage complex enterprise Kubernetes environments as code"
  homepage "https://github.com/kubecfg/kubecfg"
  url "https://github.com/kubecfg/kubecfg/archive/v0.26.0.tar.gz"
  sha256 "322ed2b6d4214bafac63ee3d666aa240b077a0949d68bc97e5b6dfc484345b7e"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/kubecfg"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "32b97a40066d46e29a8552b71b9123540ab2ed404964e992de7d3b79b12e263f"
  end

  depends_on "go" => :build

  def install
    (buildpath/"src/github.com/kubecfg/kubecfg").install buildpath.children

    cd "src/github.com/kubecfg/kubecfg" do
      system "make", "VERSION=v#{version}"
      bin.install "kubecfg"
      pkgshare.install Dir["examples/*"], "testdata/kubecfg_test.jsonnet"
      prefix.install_metafiles
    end

    output = Utils.safe_popen_read("#{bin}/kubecfg", "completion", "--shell", "bash")
    (bash_completion/"kubecfg").write output
    output = Utils.safe_popen_read("#{bin}/kubecfg", "completion", "--shell", "zsh")
    (zsh_completion/"_kubecfg").write output
  end

  test do
    system bin/"kubecfg", "show", pkgshare/"kubecfg_test.jsonnet"
  end
end
