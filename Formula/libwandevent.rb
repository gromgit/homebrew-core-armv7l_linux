class Libwandevent < Formula
  desc "API for developing event-driven programs"
  homepage "https://research.wand.net.nz/software/libwandevent.php"
  url "https://research.wand.net.nz/software/libwandevent/libwandevent-3.0.2.tar.gz"
  sha256 "48fa09918ff94f6249519118af735352e2119dc4f9b736c861ef35d59466644a"
  license "GPL-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?libwandevent[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libwandevent"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8932f41ba99043fd58cf6ae47dff0a9b86868529ca80384a0d8726a68d988cda"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-pre-0.4.2.418-big_sur.diff"
    sha256 "83af02f2aa2b746bb7225872cab29a253264be49db0ecebb12f841562d9a2923"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <sys/time.h>
      #include <libwandevent.h>

      int main() {
        wand_event_init();
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-lwandevent", "-o", "test"
    system "./test"
  end
end
