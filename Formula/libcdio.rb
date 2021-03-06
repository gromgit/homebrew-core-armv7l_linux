class Libcdio < Formula
  desc "Compact Disc Input and Control Library"
  homepage "https://www.gnu.org/software/libcdio/"
  url "https://ftp.gnu.org/gnu/libcdio/libcdio-2.1.0.tar.bz2"
  mirror "https://ftpmirror.gnu.org/libcdio/libcdio-2.1.0.tar.bz2"
  sha256 "8550e9589dbd594bfac93b81ecf129b1dc9d0d51e90f9696f1b2f9b2af32712b"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libcdio"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "4df1e91e76f88a660d9bb2298e34f3d7ec6522988e9cb38050882f5b7d6f7167"
  end

  depends_on "pkg-config" => :build

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cd-info -v", 1)
  end
end
