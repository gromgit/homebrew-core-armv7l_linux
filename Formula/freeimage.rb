class Freeimage < Formula
  desc "Library for FreeImage, a dependency-free graphics library"
  homepage "https://sourceforge.net/projects/freeimage"
  url "https://downloads.sourceforge.net/project/freeimage/Source%20Distribution/3.18.0/FreeImage3180.zip"
  version "3.18.0"
  sha256 "f41379682f9ada94ea7b34fe86bf9ee00935a3147be41b6569c9605a53e438fd"
  license "FreeImage"
  head "https://svn.code.sf.net/p/freeimage/svn/FreeImage/trunk/"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/freeimage"
    rebuild 4
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1e07ba7453f965594d0f95f53ef66c8e89a7fe271199bd77e303854c38e5c2c7"
  end

  patch do
    on_macos do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/4dcf528/freeimage/3.17.0.patch"
      sha256 "8ef390fece4d2166d58e739df76b5e7996c879efbff777a8a94bcd1dd9a313e2"
    end
    on_linux do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/master/freeimage/3.17.0-linux.patch"
      sha256 "537a4045d31a3ce1c3bab2736d17b979543758cf2081e97fff4d72786f1830dc"
    end
  end

  def install
    # Temporary workaround for ARM. Upstream tracking issue:
    # https://sourceforge.net/p/freeimage/bugs/325/
    # https://sourceforge.net/p/freeimage/discussion/36111/thread/cc4cd71c6e/
    ENV["CFLAGS"] = "-O3 -fPIC -fexceptions -fvisibility=hidden -DPNG_ARM_NEON_OPT=0" if Hardware::CPU.arm?
    system "make", "-f", "Makefile.gnu"
    system "make", "-f", "Makefile.gnu", "install", "PREFIX=#{prefix}"
    system "make", "-f", "Makefile.fip"
    system "make", "-f", "Makefile.fip", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdlib.h>
      #include <FreeImage.h>
      int main() {
         FreeImage_Initialise(0);
         FreeImage_DeInitialise();
         exit(0);
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lfreeimage", "-o", "test"
    system "./test"
  end
end
