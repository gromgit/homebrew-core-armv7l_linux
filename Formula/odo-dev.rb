class OdoDev < Formula
  desc "Developer-focused CLI for Kubernetes and OpenShift"
  homepage "https://odo.dev"
  url "https://github.com/redhat-developer/odo.git",
      tag:      "v2.5.1",
      revision: "ae0c553090e7644c3eda585639151419a8c3fb6b"
  license "Apache-2.0"
  head "https://github.com/redhat-developer/odo.git", branch: "main"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/odo-dev"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f65251740883b1f82761e4a2b38ed5269a9a989dd8cb37f6f5bce65bead88cef"
  end

  depends_on "go" => :build
  conflicts_with "odo", because: "odo also ships 'odo' binary"

  def install
    system "make", "bin"
    bin.install "odo"
  end

  test do
    # try set preference
    ENV["GLOBALODOCONFIG"] = "#{testpath}/preference.yaml"
    system bin/"odo", "preference", "set", "ConsentTelemetry", "false"
    assert_predicate testpath/"preference.yaml", :exist?

    # test version
    version_output = shell_output("#{bin}/odo version --client 2>&1").strip
    assert_match(/odo v#{version} \([a-f0-9]{9}\)/, version_output)

    # try to creation new component
    system bin/"odo", "create", "nodejs"
    assert_predicate testpath/"devfile.yaml", :exist?

    push_output = shell_output("#{bin}/odo push 2>&1", 1).strip
    assert_match("invalid configuration", push_output)
  end
end
