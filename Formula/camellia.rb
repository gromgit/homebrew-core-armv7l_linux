class Camellia < Formula
  desc "Image Processing & Computer Vision library written in C"
  homepage "https://camellia.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/camellia/Unix_Linux%20Distribution/v2.7.0/CamelliaLib-2.7.0.tar.gz"
  sha256 "a3192c350f7124d25f31c43aa17e23d9fa6c886f80459cba15b6257646b2f3d2"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    regex(%r{url=.*?/CamelliaLib[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/camellia"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "21297a7c3b4bbbd8a2b3dafd2ca7f65c85fcf2584171c4028b193fb04be9f6c3"
  end

  def install
    # Fix missing include - https://sourceforge.net/p/camellia/bugs/1/
    # cam_demo_cpp.cpp:212:52: error: ‘sprintf’ was not declared in this scope
    if OS.linux?
      inreplace "cam_demo_cpp.cpp",
                "#include <stdlib.h>\r\n",
                "#include <stdlib.h>\r\n#include <stdio.h>\r\n"
    end

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "camellia.h"
      int main() {
        CamImage image; // CamImage is an internal structure of Camellia
        return 0;
      }
    EOS

    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lCamellia", "-o", "test"
    system "./test"
  end
end
