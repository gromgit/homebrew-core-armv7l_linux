class Brotli < Formula
  desc "Generic-purpose lossless compression algorithm by Google"
  homepage "https://github.com/google/brotli"
  url "https://github.com/google/brotli/archive/v1.0.9.tar.gz"
  mirror "http://fresh-center.net/linux/misc/brotli-1.0.9.tar.gz"
  mirror "http://fresh-center.net/linux/misc/legacy/brotli-1.0.9.tar.gz"
  sha256 "f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46"
  license "MIT"
  head "https://github.com/google/brotli.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/brotli"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b4e3937ec964bfe3651d145b9b0067d3265c2111e6f512fd66b25ceaf8b95f3b"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "VERBOSE=1"
    system "ctest", "-V"
    system "make", "install"
  end

  test do
    (testpath/"file.txt").write("Hello, World!")
    system "#{bin}/brotli", "file.txt", "file.txt.br"
    system "#{bin}/brotli", "file.txt.br", "--output=out.txt", "--decompress"
    assert_equal (testpath/"file.txt").read, (testpath/"out.txt").read
  end
end
