class Crc32c < Formula
  desc "Implementation of CRC32C with CPU-specific acceleration"
  homepage "https://github.com/google/crc32c"
  url "https://github.com/google/crc32c/archive/1.1.2.tar.gz"
  sha256 "ac07840513072b7fcebda6e821068aa04889018f24e10e46181068fb214d7e56"
  license "BSD-3-Clause"
  head "https://github.com/google/crc32c.git", branch: "main"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/crc32c"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "65977f27b410b0b7b3646f5da82fd2e41627f864a284e8814cf187c025065906"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DCRC32C_BUILD_TESTS=0",
                          "-DCRC32C_BUILD_BENCHMARKS=0", "-DCRC32C_USE_GLOG=0",
                         *std_cmake_args
    system "make", "install"
    system "make", "clean"
    system "cmake", ".", "-DBUILD_SHARED_LIBS=ON", "-DCRC32C_BUILD_TESTS=0",
                         "-DCRC32C_BUILD_BENCHMARKS=0", "-DCRC32C_USE_GLOG=0",
                         *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <cassert>
      #include <crc32c/crc32c.h>
      #include <cstdint>
      #include <string>

      int main()
      {
        std::uint32_t expected = 0xc99465aa;
        std::uint32_t result = crc32c::Crc32c(std::string("hello world"));
        assert(result == expected);
        return 0;
      }
    EOS

    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lcrc32c", "-std=c++11", "-o", "test"
    system "./test"
  end
end
