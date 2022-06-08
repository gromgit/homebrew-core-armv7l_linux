class Leaps < Formula
  desc "Collaborative web-based text editing service written in Golang"
  homepage "https://github.com/jeffail/leaps"
  url "https://github.com/Jeffail/leaps/archive/v0.9.1.tar.gz"
  sha256 "8335e2a939ac5928a05f71df4014529b5b0f2097152017d691a0fb6d5ae27be4"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/leaps"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "6734c64bacd51677e4243fbaf2c8f488010ec966444eecc638f336bab5a5825d"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/leaps"
  end

  test do
    port = ":#{free_port}"

    # Start the server in a fork
    leaps_pid = fork do
      exec "#{bin}/leaps", "-address", port
    end

    # Give the server some time to start serving
    sleep(1)

    # Check that the server is responding correctly
    assert_match "You are alone", shell_output("curl -o- http://localhost#{port}")
  ensure
    # Stop the server gracefully
    Process.kill("HUP", leaps_pid)
  end
end
