class Concurrencykit < Formula
  desc "Aid design and implementation of concurrent systems"
  homepage "http://concurrencykit.org/"
  url "https://github.com/concurrencykit/ck/archive/0.7.0.tar.gz"
  sha256 "e730cb448fb0ecf9d19bf4c7efe9efc3c04dd9127311d87d8f91484742b0da24"
  license "BSD-2-Clause"
  head "https://github.com/concurrencykit/ck.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/concurrencykit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ca07487acb16fa7ac1666d21ffe109dab6f528226fc943605cb9fa3c04b8e115"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <ck_spinlock.h>
      int main()
      {
        ck_spinlock_t spinlock;
        ck_spinlock_init(&spinlock);
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lck",
           testpath/"test.c", "-o", testpath/"test"
    system "./test"
  end
end
