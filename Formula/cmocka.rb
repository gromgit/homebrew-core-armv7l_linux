class Cmocka < Formula
  desc "Unit testing framework for C"
  homepage "https://cmocka.org/"
  url "https://cmocka.org/files/1.1/cmocka-1.1.5.tar.xz"
  sha256 "f0ccd8242d55e2fd74b16ba518359151f6f8383ff8aef4976e48393f77bba8b6"
  license "Apache-2.0"
  head "https://git.cryptomilk.org/projects/cmocka.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cmocka"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "47a08cc53834c82f0233009b6ce39081c7e1488aeefe015338b46d171b97dcb9"
  end

  depends_on "cmake" => :build

  def install
    args = std_cmake_args
    args << "-DWITH_STATIC_LIB=ON" << "-DWITH_CMOCKERY_SUPPORT=ON" << "-DUNIT_TESTING=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdarg.h>
      #include <stddef.h>
      #include <setjmp.h>
      #include <cmocka.h>

      static void null_test_success(void **state) {
        (void) state; /* unused */
      }

      int main(void) {
        const struct CMUnitTest tests[] = {
            cmocka_unit_test(null_test_success),
        };
        return cmocka_run_group_tests(tests, NULL, NULL);
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lcmocka", "-o", "test"
    system "./test"
  end
end
