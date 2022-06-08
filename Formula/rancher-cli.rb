class RancherCli < Formula
  desc "Unified tool to manage your Rancher server"
  homepage "https://github.com/rancher/cli"
  url "https://github.com/rancher/cli/archive/v2.6.5.tar.gz"
  sha256 "fd55429e52ffe645438347ba5b9fe6962bfedc1cd40285c7b365a0cad69f1fb5"
  license "Apache-2.0"
  head "https://github.com/rancher/cli.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/rancher-cli"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "91a8eac534745a643f3e3302fe5c78efc3e9dbb2ad43b132725b314a7e391bb9"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.VERSION=#{version}"), "-o", bin/"rancher"
  end

  test do
    assert_match "Failed to parse SERVERURL", shell_output("#{bin}/rancher login localhost -t foo 2>&1", 1)
    assert_match "invalid token", shell_output("#{bin}/rancher login https://127.0.0.1 -t foo 2>&1", 1)
  end
end
