class GoogleBenchmark < Formula
  desc "C++ microbenchmark support library"
  homepage "https://github.com/google/benchmark"
  url "https://github.com/google/benchmark/archive/v1.6.1.tar.gz"
  sha256 "6132883bc8c9b0df5375b16ab520fac1a85dc9e4cf5be59480448ece74b278d4"
  license "Apache-2.0"
  head "https://github.com/google/benchmark.git", branch: "main"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/google-benchmark"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "edb9889033626ad9b04384ad3defbaa12c0b1d4e889b7c975373a58e2dced7b7"
  end

  depends_on "cmake" => :build

  def install
    ENV.cxx11
    system "cmake", "-DBENCHMARK_ENABLE_GTEST_TESTS=OFF", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <string>
      #include <benchmark/benchmark.h>
      static void BM_StringCreation(benchmark::State& state) {
        while (state.KeepRunning())
          std::string empty_string;
      }
      BENCHMARK(BM_StringCreation);
      BENCHMARK_MAIN();
    EOS
    flags = ["-I#{include}", "-L#{lib}", "-lbenchmark", "-pthread"] + ENV.cflags.to_s.split
    system ENV.cxx, "-o", "test", "test.cpp", *flags
    system "./test"
  end
end
