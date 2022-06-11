class Bgpdump < Formula
  desc "C library for analyzing MRT/Zebra/Quagga dump files"
  homepage "https://github.com/RIPE-NCC/bgpdump/wiki"
  url "https://github.com/RIPE-NCC/bgpdump/archive/v1.6.2.tar.gz"
  sha256 "415692c173a84c48b1e927a6423a4f8fd3e6359bc3008c06b7702fe143a76223"
  license "GPL-2.0"

  livecheck do
    url "https://github.com/RIPE-NCC/bgpdump.git"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bgpdump"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3d71a48c6781b9b6e219efff7cb7c8430b174e3f0b335c16c62a02458708799b"
  end

  depends_on "autoconf" => :build

  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  def install
    system "./bootstrap.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"bgpdump", "-T"
  end
end
