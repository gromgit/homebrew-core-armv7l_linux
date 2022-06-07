class Fabio < Formula
  desc "Zero-conf load balancing HTTP(S) router"
  homepage "https://github.com/fabiolb/fabio"
  url "https://github.com/fabiolb/fabio/archive/v1.6.0.tar.gz"
  sha256 "2a3a678a3ee7a5415512a1b3b799352186859f5d4dd50330d1117b21a643c398"
  license "MIT"
  head "https://github.com/fabiolb/fabio.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fabio"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8651c2b098614cfacfe71375eb67348ad2a2f1a7fd9258fd6d2de819a4e377cb"
  end

  depends_on "go" => :build
  depends_on "consul"

  def install
    system "go", "build", "-ldflags", "-s -w", "-trimpath", "-o", bin/"fabio"
    prefix.install_metafiles
  end

  test do
    require "socket"
    require "timeout"

    consul_default_port = 8500
    fabio_default_port = 9999
    localhost_ip = "127.0.0.1".freeze

    def port_open?(ip_address, port, seconds = 1)
      Timeout.timeout(seconds) do
        TCPSocket.new(ip_address, port).close
      end
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Timeout::Error
      false
    end

    if port_open?(localhost_ip, fabio_default_port)
      puts "Fabio already running or Consul not available or starting fabio failed."
      false
    else
      if port_open?(localhost_ip, consul_default_port)
        puts "Consul already running"
      else
        fork do
          exec "consul agent -dev -bind 127.0.0.1"
        end
        sleep 30
      end
      fork do
        exec "#{bin}/fabio"
      end
      sleep 10
      assert_equal true, port_open?(localhost_ip, fabio_default_port)
      system "consul", "leave"
    end
  end
end
