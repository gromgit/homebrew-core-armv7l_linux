class Libforensic1394 < Formula
  desc "Live memory forensics over IEEE 1394 (\"FireWire\") interface"
  homepage "https://freddie.witherden.org/tools/libforensic1394/"
  url "https://freddie.witherden.org/tools/libforensic1394/releases/libforensic1394-0.2.tar.gz"
  sha256 "50a82fe2899aa901104055da2ac00b4c438cf1d0d991f5ec1215d4658414652e"
  license "LGPL-3.0-or-later"
  head "https://github.com/FreddieWitherden/libforensic1394.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?libforensic1394[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libforensic1394"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c948261a7ca7021747a9b7391cd257a40a4205638c812703b18a40070ae2bf6c"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <forensic1394.h>
      int main() {
        forensic1394_bus *bus;
        bus = forensic1394_alloc();
        assert(NULL != bus);
        forensic1394_destroy(bus);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lforensic1394", "-o", "test"
    system "./test"
  end
end
