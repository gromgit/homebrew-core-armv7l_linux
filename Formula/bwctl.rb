class Bwctl < Formula
  desc "Command-line tool and daemon for network measuring tools"
  homepage "https://software.internet2.edu/bwctl/"
  url "https://software.internet2.edu/sources/bwctl/bwctl-1.5.4.tar.gz"
  sha256 "e6dca6ca30c8ef4d68e6b34b011a9ff7eff3aba4a84efc19d96e3675182e40ef"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bwctl"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ad52d44f1d18f6bd1b7101c6c555b9a0a36cbddf542cfa33476185e734f6ab4b"
  end

  # https://software.internet2.edu/bwctl/
  # The use of BWCTL became deprecated with the release of pScheduler in perfSONAR 4.0 in April, 2017.
  deprecate! date: "2017-04-01", because: :deprecated_upstream

  depends_on "i2util" => :build

  def install
    # configure mis-sets CFLAGS for I2util
    # https://lists.internet2.edu/sympa/arc/perfsonar-user/2015-04/msg00016.html
    # https://github.com/Homebrew/homebrew/pull/38212
    inreplace "configure", 'CFLAGS="-I$I2util_dir/include $CFLAGS"', 'CFLAGS="-I$with_I2util/include $CFLAGS"'

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-I2util=#{Formula["i2util"].opt_prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/bwctl", "-V"
  end
end
