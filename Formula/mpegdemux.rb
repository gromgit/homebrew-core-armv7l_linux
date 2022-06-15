class Mpegdemux < Formula
  desc "MPEG1/2 system stream demultiplexer"
  homepage "http://www.hampa.ch/mpegdemux/"
  url "http://www.hampa.ch/mpegdemux/mpegdemux-0.1.4.tar.gz"
  sha256 "0067c31398ed08d3a4f62713bbcc6e4a83591290a599c66cdd8f5a3e4c410419"
  license "GPL-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?mpegdemux[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mpegdemux"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "72daa4cc18b18a7a9d25d8d9117e560638a1de84790284dcbc65fdb7eda8c9ca"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/mpegdemux", "--help"
  end
end
