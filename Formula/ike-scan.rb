class IkeScan < Formula
  desc "Discover and fingerprint IKE hosts"
  homepage "https://github.com/royhills/ike-scan"
  url "https://github.com/royhills/ike-scan/archive/1.9.5.tar.gz"
  sha256 "5152bf06ac82d0cadffb93a010ffb6bca7efd35ea169ca7539cf2860ce2b263f"
  license "GPL-3.0-or-later"
  head "https://github.com/royhills/ike-scan.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ike-scan"
    rebuild 1
    sha256 armv7l_linux: "10129ec3f231a11ab7453b8df1c94f0b0a5833c21859916c173f0628f24cb532"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "openssl@1.1"

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-openssl=#{Formula["openssl@1.1"].opt_prefix}"
    system "make", "install"
  end

  test do
    # We probably shouldn't probe any host for VPN servers, so let's keep this simple.
    system bin/"ike-scan", "--version"
  end
end
