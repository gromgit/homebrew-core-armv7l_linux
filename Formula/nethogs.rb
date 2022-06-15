class Nethogs < Formula
  desc "Net top tool grouping bandwidth per process"
  homepage "https://raboof.github.io/nethogs/"
  url "https://github.com/raboof/nethogs/archive/v0.8.7.tar.gz"
  sha256 "957d6afcc220dfbba44c819162f44818051c5b4fb793c47ba98294393986617d"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/nethogs"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "10f01875754db7ecee5c4d99247306291f5807170f175550b68b4423dc5dacf4"
  end

  uses_from_macos "libpcap"
  uses_from_macos "ncurses"

  def install
    ENV.append "CXXFLAGS", "-std=c++14"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    # Using -V because other nethogs commands need to be run as root
    system sbin/"nethogs", "-V"
  end
end
