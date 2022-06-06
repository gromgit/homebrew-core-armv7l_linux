class ArgocdAutopilot < Formula
  desc "Opinionated way of installing Argo CD and managing GitOps repositories"
  homepage "https://argoproj.io"
  url "https://github.com/argoproj-labs/argocd-autopilot.git",
      tag:      "v0.3.7",
      revision: "9ba4ca5f5b489bd8f30a3f017a745d2863af795b"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/argocd-autopilot"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e20525016e21d3217169c8f9013585692606bd7f5e0203531575cb6f5e0d0d34"
  end

  depends_on "go" => :build

  def install
    system "make", "cli-package", "DEV_MODE=false"
    bin.install "dist/argocd-autopilot"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/argocd-autopilot version")

    assert_match "required flag(s) \\\"git-token\\\" not set\"",
      shell_output("#{bin}/argocd-autopilot repo bootstrap --repo https://github.com/example/repo 2>&1", 1)
  end
end
