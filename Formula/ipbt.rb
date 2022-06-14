class Ipbt < Formula
  desc "Program for recording a UNIX terminal session"
  homepage "https://www.chiark.greenend.org.uk/~sgtatham/ipbt/"
  url "https://www.chiark.greenend.org.uk/~sgtatham/ipbt/ipbt-20220403.d4e7fcd.tar.gz"
  version "20220403"
  sha256 "8c7f325166b86055232cca9d745c6a18dcdcb6d30a0685e07ac0eab677912b05"
  license "MIT"

  livecheck do
    url :homepage
    regex(/href=.*?ipbt[._-]v?(\d+(?:\.\d+)*)(?:[._-][\da-z]+)?\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ipbt"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c41d0904c74f1189ffb6b08e0a4393d3edb2347e3ef0aa17216131ecf1a74e61"
  end

  depends_on "cmake" => :build

  uses_from_macos "ncurses"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/ipbt"
  end
end
