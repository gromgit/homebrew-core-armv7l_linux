class Dhcpdump < Formula
  desc "Monitor DHCP traffic for debugging purposes"
  homepage "https://www.mavetju.org/unix/general.php"
  url "https://www.mavetju.org/download/dhcpdump-1.8.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/d/dhcpdump/dhcpdump_1.8.orig.tar.gz"
  sha256 "6d5eb9418162fb738bc56e4c1682ce7f7392dd96e568cc996e44c28de7f77190"

  livecheck do
    url :homepage
    regex(/href=.*?dhcpdump[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dhcpdump"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a1cb3f707a38dde1fbb9a0925084fb7bb52e427249898031626c174cdde5390d"
  end

  uses_from_macos "libpcap"

  def install
    system "make", "CFLAGS=-DHAVE_STRSEP"
    bin.install "dhcpdump"
    man8.install "dhcpdump.8"
  end

  test do
    system "#{bin}/dhcpdump", "-h"
  end
end
