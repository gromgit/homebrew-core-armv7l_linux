class Primesieve < Formula
  desc "Fast C/C++ prime number generator"
  homepage "https://github.com/kimwalisch/primesieve"
  url "https://github.com/kimwalisch/primesieve/archive/v7.9.tar.gz"
  sha256 "c567f2a1a9d46a70020f920eb2c794142528a31a055995500e7fcb19642b7c91"
  license "BSD-2-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/primesieve"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "9a938c692d48d3332a5864a2b45c7f3d5a4bdb977ea8e7dab263a8c250dfa0c9"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_INSTALL_RPATH=#{rpath}", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/primesieve", "100", "--count", "--print"
  end
end
