class Mpir < Formula
  desc "Multiple Precision Integers and Rationals (fork of GMP)"
  homepage "https://mpir.org/"
  url "https://mpir.org/mpir-3.0.0.tar.bz2"
  sha256 "52f63459cf3f9478859de29e00357f004050ead70b45913f2c2269d9708675bb"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://mpir.org/downloads.html"
    regex(/href=.*?mpir[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mpir"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "5c89476881ba89fb5a137fa53b644c09431cdfd47c343ce121df6cf04cd38405"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "yasm" => :build

  # Fix Xcode 12 build: https://github.com/wbhart/mpir/pull/292
  patch do
    url "https://github.com/wbhart/mpir/commit/bbc43ca6ae0bec4f64e69c9cd4c967005d6470eb.patch?full_index=1"
    sha256 "8c0ec267c62a91fe6c21d43467fee736fb5431bd9e604dc930cc71048f4e3452"
  end

  def install
    # Regenerate ./configure script due to patch above
    system "autoreconf", "--verbose", "--install", "--force"
    args = %W[--disable-silent-rules --prefix=#{prefix} --enable-cxx]
    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <mpir.h>
      #include <stdlib.h>

      int main() {
        mpz_t i, j, k;
        mpz_init_set_str (i, "1a", 16);
        mpz_init (j);
        mpz_init (k);
        mpz_sqrtrem (j, k, i);
        if (mpz_get_si (j) != 5 || mpz_get_si (k) != 1) abort();
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lmpir", "-o", "test"
    system "./test"
  end
end
