class Conftest < Formula
  desc "Test your configuration files using Open Policy Agent"
  homepage "https://www.conftest.dev/"
  url "https://github.com/open-policy-agent/conftest/archive/v0.32.1.tar.gz"
  sha256 "94e3227229c4b3ef86da85d64a877214fd627e3140bb1e28275620aa94013f7a"
  license "Apache-2.0"
  head "https://github.com/open-policy-agent/conftest.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/conftest"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1826263777efe30b38bf27623cd70106c55247348760b38e00e6073b64182974"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-X github.com/open-policy-agent/conftest/internal/commands.version=#{version}")

    bash_output = Utils.safe_popen_read(bin/"conftest", "completion", "bash")
    (bash_completion/"conftest").write bash_output

    zsh_output = Utils.safe_popen_read(bin/"conftest", "completion", "zsh")
    (zsh_completion/"_conftest").write zsh_output

    fish_output = Utils.safe_popen_read(bin/"conftest", "completion", "fish")
    (fish_completion/"conftest.fish").write fish_output
  end

  test do
    assert_match "Test your configuration files using Open Policy Agent", shell_output("#{bin}/conftest --help")

    # Using the policy parameter changes the default location to look for policies.
    # If no policies are found, a non-zero status code is returned.
    (testpath/"test.rego").write("package main")
    system "#{bin}/conftest", "verify", "-p", "test.rego"
  end
end
