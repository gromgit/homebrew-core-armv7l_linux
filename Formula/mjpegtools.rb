class Mjpegtools < Formula
  desc "Record and playback videos and perform simple edits"
  homepage "https://mjpeg.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/mjpeg/mjpegtools/2.2.1/mjpegtools-2.2.1.tar.gz"
  sha256 "b180536d7d9960b05e0023a197b00dcb100929a49aab71d19d55f4a1b210f49a"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mjpegtools"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "271c836b0c080b306796481460dc849a3bcf65f1c1de29eaa22b5ec9c1925fa4"
  end

  depends_on "pkg-config" => :build
  depends_on "jpeg"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--enable-simd-accel",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
