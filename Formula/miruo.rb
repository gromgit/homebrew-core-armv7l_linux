class Miruo < Formula
  desc "Pretty-print TCP session monitor/analyzer"
  homepage "https://github.com/KLab/miruo/"
  url "https://github.com/KLab/miruo/archive/0.9.6b.tar.gz"
  version "0.9.6b"
  sha256 "0b31a5bde5b0e92a245611a8e671cec3d330686316691daeb1de76360d2fa5f1"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/miruo"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "9620ccc5e01bf638de6afeec961ab22aa19a1e2682f2609d9664b22e77db868a"
  end

  uses_from_macos "libpcap"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--with-libpcap=#{MacOS.sdk_path}/usr"
    system "make", "install"
  end

  test do
    (testpath/"dummy.pcap").write "\xd4\xc3\xb2\xa1\x02\x00\x04\x00\x00\x00\x00\x00" \
                                  "\x00\x00\x00\x00\xff\xff\x00\x00\x01\x00\x00\x00"
    system "#{sbin}/miruo", "--file=dummy.pcap"
  end
end
