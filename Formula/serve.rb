class Serve < Formula
  desc "Static http server anywhere you need one"
  homepage "https://github.com/syntaqx/serve"
  url "https://github.com/syntaqx/serve/archive/v0.5.0.tar.gz"
  sha256 "fab576aa29b14dcfc45ba6e0e7e6b5284a83e873b75992399b3f5ef8d415d6ae"
  license "MIT"
  head "https://github.com/syntaqx/serve.git", branch: "main"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/serve"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ced4e06d605a6c3022907ce2cd5d02c65973ffd34e033d8db7a556475ea1d1e1"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=#{version}", *std_go_args, "./cmd/serve"
  end

  test do
    port = free_port
    pid = fork do
      exec "#{bin}/serve -port #{port}"
    end
    sleep 1
    output = shell_output("curl -sI http://localhost:#{port}")
    assert_match(/200 OK/m, output)
  ensure
    Process.kill("HUP", pid)
  end
end
