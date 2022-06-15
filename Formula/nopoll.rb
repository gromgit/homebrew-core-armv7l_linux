class Nopoll < Formula
  desc "Open-source C WebSocket toolkit"
  homepage "https://www.aspl.es/nopoll/"
  url "https://www.aspl.es/nopoll/downloads/nopoll-0.4.7.b429.tar.gz"
  version "0.4.7.b429"
  sha256 "d5c020fec25e3fa486c308249833d06bed0d76bde9a72fd5d73cfb057c320366"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://www.aspl.es/nopoll/downloads/"
    regex(/href=.*?nopoll[._-]v?(\d+(?:\.\d+)+(?:\.b\d+)?)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/nopoll"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "9cff4f53d3a62894ff006a930f7e90500783d28d062d930090043a76b4fd6e64"
  end

  depends_on "openssl@1.1"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <nopoll.h>
      int main(void) {
        noPollCtx *ctx = nopoll_ctx_new();
        nopoll_ctx_unref(ctx);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}/nopoll", "-L#{lib}", "-lnopoll",
           "-o", "test"
    system "./test"
  end
end
