class Libcuefile < Formula
  desc "Library to work with CUE files"
  homepage "https://www.musepack.net/"
  url "https://files.musepack.net/source/libcuefile_r475.tar.gz"
  version "r475"
  sha256 "b681ca6772b3f64010d24de57361faecf426ee6182f5969fcf29b3f649133fe7"
  license "GPL-2.0"

  livecheck do
    url "https://www.musepack.net/index.php?pg=src"
    regex(/href=.*?libcuefile[._-](r\d+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libcuefile"
    rebuild 2
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e49cf1411f865c7317ecf393d0b461f7143f784f46870698c8afb510fe938035"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    include.install "include/cuetools/"
  end
end
