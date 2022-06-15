class Libdill < Formula
  desc "Structured concurrency in C"
  homepage "http://libdill.org/"
  url "https://github.com/sustrik/libdill/archive/2.14.tar.gz"
  sha256 "ebba0e5b433ec123b74a57d49b89dfa673aa258e03e6a452959e556b4c4529b9"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libdill"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ddbe6a0ea843c17cbc74cfdf162b58922fc7e718d01aec698c2f1371aa88ee8f"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libdill.h>
      #include <stdio.h>
      #include <stdlib.h>

      coroutine void worker(const char *text) {
          while(1) {
              printf("%s\\n", text);
              msleep(now() + random() % 500);
          }
      }

      int main() {
          go(worker("Hello!"));
          go(worker("World!"));
          msleep(now() + 5000);
          return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-ldill", "-o", "test"
    system "./test"
  end
end
