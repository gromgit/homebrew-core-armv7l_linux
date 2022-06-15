class Ntp < Formula
  desc "Network Time Protocol (NTP) Distribution"
  homepage "https://www.eecis.udel.edu/~mills/ntp/html/"
  url "https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/ntp-4.2.8p15.tar.gz"
  version "4.2.8p15"
  sha256 "f65840deab68614d5d7ceb2d0bb9304ff70dcdedd09abb79754a87536b849c19"

  # This approach is a temporary workaround while www.ntp.org is experiencing
  # SSL certificate issues. Once this issue is resolved, we should reinstate
  # the previous check.
  livecheck do
    # url "https://www.ntp.org/downloads.html"
    # regex(/href=.*?ntp[._-]v?(\d+(?:\.\d+)+(?:p\d+)?)\.t/i)
    url "https://support.ntp.org/rss/releases.xml"
    regex(%r{/ntp[._-]v?(\d+(?:\.\d+)+(?:p\d+)?)\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ntp"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ed6a0a0a85e53fc24b8acb9e00adb0d865b293939afca3d0d176e8bab179dcc7"
  end

  depends_on "openssl@1.1"

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-openssl-libdir=#{Formula["openssl@1.1"].lib}
      --with-openssl-incdir=#{Formula["openssl@1.1"].include}
      --with-net-snmp-config=no
    ]

    system "./configure", *args
    ldflags = "-lresolv"
    ldflags = "#{ldflags} -undefined dynamic_lookup" if OS.mac?
    system "make", "install", "LDADD_LIBNTP=#{ldflags}"
  end

  test do
    # On Linux all binaries are installed in bin, while on macOS they are split between bin and sbin.
    ntpdate_bin = OS.mac? ? sbin/"ntpdate" : bin/"ntpdate"
    assert_match "step time server ", shell_output("#{ntpdate_bin} -bq pool.ntp.org")
  end
end
