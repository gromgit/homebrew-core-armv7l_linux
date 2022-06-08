class Orgalorg < Formula
  desc "Parallel SSH commands executioner and file synchronization tool"
  homepage "https://github.com/reconquest/orgalorg"
  url "https://github.com/reconquest/orgalorg.git",
      tag:      "1.2.0",
      revision: "5024122fb3efaad577fa509e2d17aab1f12217de"
  license "MIT"
  head "https://github.com/reconquest/orgalorg.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/orgalorg"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d7ba383dd4b80ebd04966687884fe570f829f7f54240bfa01a11037e20f02ede"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-mod=mod", "-ldflags", "-s -w -X main.version=#{version}", *std_go_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/orgalorg --version")
    assert_match "orgalorg - files synchronization on many hosts.", shell_output("#{bin}/orgalorg --help")

    ENV.delete "SSH_AUTH_SOCK"

    port = free_port
    output = shell_output("#{bin}/orgalorg -u tester --key '' --host=127.0.0.1:#{port} -C uptime 2>&1", 1)
    assert_match("connecting to cluster failed", output)
    assert_match("dial tcp 127.0.0.1:#{port}: connect: connection refused", output)
    assert_match("can't connect to address: [tester@127.0.0.1:#{port}]", output)
  end
end
