class Libtirpc < Formula
  desc "Port of Sun's Transport-Independent RPC library to Linux"
  homepage "https://sourceforge.net/projects/libtirpc/"
  url "https://downloads.sourceforge.net/project/libtirpc/libtirpc/1.3.2/libtirpc-1.3.2.tar.bz2"
  sha256 "e24eb88b8ce7db3b7ca6eb80115dd1284abc5ec32a8deccfed2224fc2532b9fd"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libtirpc"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c4d3977c34b1875b82b97da02329eebc780e96e1b3f09af221a2c485b6a166ae"
  end

  depends_on "krb5"
  depends_on :linux

  def install
    system "./configure",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <rpc/des_crypt.h>
      #include <stdio.h>
      int main () {
        char key[] = "My8digitkey1234";
        if (sizeof(key) != 16)
          return 1;
        des_setparity(key);
        printf("%lu\\n", sizeof(key));
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}/tirpc", "-ltirpc", "-o", "test"
    system "./test"
  end
end
