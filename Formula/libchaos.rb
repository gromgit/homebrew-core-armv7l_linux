class Libchaos < Formula
  desc "Advanced library for randomization, hashing and statistical analysis"
  homepage "https://github.com/maciejczyzewski/libchaos"
  url "https://github.com/maciejczyzewski/libchaos/releases/download/v1.0/libchaos-1.0.tar.gz"
  sha256 "29940ff014359c965d62f15bc34e5c182a6d8a505dc496c636207675843abd15"
  license "BSD-2-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libchaos"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c5c5ff5e92163bb09037cc76c06a2d5c614b16459a590f358cf16156afe885b8"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DLIBCHAOS_ENABLE_TESTING=OFF",
           "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    system "cmake", "-S", ".", "-B", "build", "-DLIBCHAOS_ENABLE_TESTING=OFF",
           "-DBUILD_SHARED_LIBS=OFF", *std_cmake_args
    system "cmake", "--build", "build"
    lib.install buildpath/"build/libchaos.a"
  end

  test do
    (testpath/"test.cc").write <<~EOS
      #include <chaos.h>
      #include <iostream>
      #include <string>

      int main(void) {
        std::cout << CHAOS_META_NAME(CHAOS_MACHINE_XORRING64) << std::endl;
        std::string hash = chaos::password<CHAOS_MACHINE_XORRING64, 175, 25, 40>(
            "some secret password", "my private salt");
        std::cout << hash << std::endl;
        if (hash.size() != 40)
          return 1;
        return 0;
      }
    EOS

    system ENV.cxx, "test.cc", "-std=c++11", "-L#{lib}", "-lchaos", "-o", "test"
    system "./test"
  end
end
