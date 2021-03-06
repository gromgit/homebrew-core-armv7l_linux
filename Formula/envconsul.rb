class Envconsul < Formula
  desc "Launch process with environment variables from Consul and Vault"
  homepage "https://github.com/hashicorp/envconsul"
  url "https://github.com/hashicorp/envconsul.git",
      tag:      "v0.12.1",
      revision: "265f933f17eb918e38b24fd1a7b1eab1fc723df5"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/envconsul"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "79a96ef52760a5a46bb6619b1b17093a63eed2254496ec3bf95a6a79557f5b29"
  end

  depends_on "go" => :build
  depends_on "consul" => :test

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    port = free_port
    begin
      fork do
        exec "consul agent -dev -bind 127.0.0.1 -http-port #{port}"
        puts "consul started"
      end
      sleep 5

      system "consul", "kv", "put", "-http-addr", "127.0.0.1:#{port}", "homebrew-recipe-test/working", "1"
      output = shell_output("#{bin}/envconsul -consul-addr=127.0.0.1:#{port} " \
                            "-upcase -prefix homebrew-recipe-test env")
      assert_match "WORKING=1", output
    ensure
      system "consul", "leave", "-http-addr", "127.0.0.1:#{port}"
    end
  end
end
