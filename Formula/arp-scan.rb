class ArpScan < Formula
  desc "ARP scanning and fingerprinting tool"
  homepage "https://github.com/royhills/arp-scan"
  url "https://github.com/royhills/arp-scan/archive/1.9.7.tar.gz"
  sha256 "e03c36e4933c655bd0e4a841272554a347cd0136faf42c4a6564059e0761c039"
  license "GPL-3.0"
  head "https://github.com/royhills/arp-scan.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/arp-scan"
    sha256 armv7l_linux: "5bb66d73e79620583bb3d97e4ff01bf11434753e52195df27fc531f917e02392"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libpcap"

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/arp-scan", "-V"
  end
end
