class Ktoblzcheck < Formula
  desc "Library for German banks"
  homepage "https://ktoblzcheck.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/ktoblzcheck/ktoblzcheck-1.53.tar.gz"
  sha256 "18b9118556fe83240f468f770641d2578f4ff613cdcf0a209fb73079ccb70c55"
  license "LGPL-2.1-or-later"
  revision 2

  livecheck do
    url :stable
    regex(%r{url=.*?/ktoblzcheck[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ktoblzcheck"
    sha256 armv7l_linux: "784a07403a7a846cf127ee4e8f2ac40d22623b647179d12445044694bc415297"
  end

  depends_on "cmake" => :build
  depends_on "python@3.10"

  def install
    system "cmake", ".", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{opt_lib}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "Ok", shell_output("#{bin}/ktoblzcheck --outformat=oneline 10000000 123456789")
    assert_match "unknown", shell_output("#{bin}/ktoblzcheck --outformat=oneline 12345678 100000000", 3)
  end
end
