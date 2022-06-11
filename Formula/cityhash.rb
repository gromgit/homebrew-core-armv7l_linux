class Cityhash < Formula
  desc "Hash functions for strings"
  homepage "https://github.com/google/cityhash"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/cityhash/cityhash-1.1.1.tar.gz"
  sha256 "76a41e149f6de87156b9a9790c595ef7ad081c321f60780886b520aecb7e3db4"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cityhash"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d657fbb08bde200de990ec6b5860eb2444301fe091a88b29647b294c3be5af48"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-pre-0.4.2.418-big_sur.diff"
    sha256 "83af02f2aa2b746bb7225872cab29a253264be49db0ecebb12f841562d9a2923"
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <stdio.h>
      #include <inttypes.h>
      #include <city.h>

      int main() {
        const char* a = "This is my test string";
        uint64_t result = CityHash64(a, sizeof(a));
        printf("%" PRIx64 "\\n", result);
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lcityhash", "-o", "test"
    assert_equal "ab7a556ed7598b04", shell_output("./test").chomp
  end
end
