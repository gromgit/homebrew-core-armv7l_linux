class Mbw < Formula
  desc "Memory Bandwidth Benchmark"
  homepage "https://github.com/raas/mbw/"
  url "https://github.com/raas/mbw/archive/refs/tags/v1.5.tar.gz"
  sha256 "3c396ce09bb78c895e4d45e99b1ae07f80e3ea5eee59d78ed2048a7f2ae591ae"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mbw"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a2fdb23d73b25cc675da07e479e1a43ddf1159c5dbddf847927df7110aea7357"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "AVG\tMethod: MEMCPY\tElapsed", pipe_output("#{bin}/mbw 8", 0)
  end
end
