class LibxmpLite < Formula
  desc "Lite libxmp"
  homepage "https://xmp.sourceforge.io"
  url "https://downloads.sourceforge.net/project/xmp/libxmp/4.5.0/libxmp-lite-4.5.0.tar.gz"
  sha256 "19a019abd5a3ddf449cd20ca52cfe18970f6ab28abdffdd54cff563981a943bb"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libxmp-lite"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "de50f1d56ecbb87c5daf4fe4161a31d1e61765fe2ef1972baffe1f9d0337461b"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~'EOS'
      #include <stdio.h>
      #include <libxmp-lite/xmp.h>

      int main(int argc, char* argv[]){
        printf("libxmp-lite %s/%c%u\n", XMP_VERSION, *xmp_version, xmp_vercode);
        return 0;
      }
    EOS

    system ENV.cc, "test.c", "-I", include, "-L", lib, "-L#{lib}", "-lxmp-lite", "-o", "test"
    system "#{testpath}/test"
  end
end
