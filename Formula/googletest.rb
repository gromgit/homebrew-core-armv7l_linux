class Googletest < Formula
  desc "Google Testing and Mocking Framework"
  homepage "https://github.com/google/googletest"
  url "https://github.com/google/googletest/archive/release-1.11.0.tar.gz"
  sha256 "b4870bf121ff7795ba20d20bcdd8627b8e088f2d1dab299a031c1034eddc93d5"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/googletest"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "605a096537008e2574679c9e87848eddcd071d07c2452cbc1a1140b113c5b883"
  end

  depends_on "cmake" => :build

  conflicts_with "nss", because: "both install `libgtest.a`"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"

    # for use case like `#include "googletest/googletest/src/gtest-all.cc"`
    (include/"googlemock/googlemock/src").install Dir["googlemock/src/*"]
    (include/"googletest/googletest/src").install Dir["googletest/src/*"]
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <gtest/gtest.h>
      #include <gtest/gtest-death-test.h>

      TEST(Simple, Boolean)
      {
        ASSERT_TRUE(true);
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-L#{lib}", "-lgtest", "-lgtest_main", "-pthread", "-o", "test"
    system "./test"
  end
end
