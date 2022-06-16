class Ptunnel < Formula
  desc "Tunnel over ICMP"
  homepage "https://www.cs.uit.no/~daniels/PingTunnel/"
  url "https://www.cs.uit.no/~daniels/PingTunnel/PingTunnel-0.72.tar.gz"
  sha256 "b318f7aa7d88918b6269d054a7e26f04f97d8870f47bd49a76cb2c99c73407a4"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?PingTunnel[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ptunnel"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b0e10d7e7497a3dd4293d2c2b28a583aaf81aa21aeba7ae5142b9a469d315bcd"
  end

  uses_from_macos "libpcap"

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  def caveats
    <<~EOS
      Normally, ptunnel uses raw sockets and must be run as root (using sudo, for example).

      Alternatively, you can try using the -u flag to start ptunnel in 'unprivileged' mode,
      but this is not recommended. See https://www.cs.uit.no/~daniels/PingTunnel/ for details.
    EOS
  end

  test do
    assert_match "v #{version}", shell_output("#{bin}/ptunnel -h", 1)
  end
end
