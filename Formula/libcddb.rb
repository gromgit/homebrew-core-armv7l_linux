class Libcddb < Formula
  desc "CDDB server access library"
  homepage "https://libcddb.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/libcddb/libcddb/1.3.2/libcddb-1.3.2.tar.bz2"
  sha256 "35ce0ee1741ea38def304ddfe84a958901413aa829698357f0bee5bb8f0a223b"
  revision 4

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libcddb"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d716720a527434dcadbd36e3c879a10ec579a83e597dce07f5b3aea11a27597d"
  end

  depends_on "pkg-config" => :build
  depends_on "libcdio"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <cddb/cddb.h>
      int main(void) {
        cddb_track_t *track = cddb_track_new();
        cddb_track_destroy(track);
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lcddb", "-o", "test"
    system "./test"
  end
end
