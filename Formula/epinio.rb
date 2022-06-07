class Epinio < Formula
  desc "CLI for Epinio, the Application Development Engine for Kubernetes"
  homepage "https://epinio.io/"
  url "https://github.com/epinio/epinio/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "25eeb7ac7f12fcb9f20845d8f340ab74dad24e467761f9658aaa3f864319c036"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/epinio"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ae7a62e2adc62bf42d6614557c0b89dfe4cd1ce356827b1b78cc8d42a8656928"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/epinio/epinio/internal/version.Version=#{version}")
  end

  test do
    output = shell_output("#{bin}/epinio version 2>&1")
    assert_match "Epinio Version: #{version}", output

    output = shell_output("#{bin}/epinio settings update 2>&1", 255)
    assert_match "failed to get kube config", output
    assert_match "no configuration has been provided", output
  end
end
