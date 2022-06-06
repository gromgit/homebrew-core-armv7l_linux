class Aterm < Formula
  desc "Annotated Term for tree-like ADT exchange"
  homepage "https://web.archive.org/web/20180902175600/meta-environment.org/Meta-Environment/ATerms.html"
  url "https://web.archive.org/web/20150503094402/meta-environment.org/releases/aterm-2.8.tar.gz"
  sha256 "bab69c10507a16f61b96182a06cdac2f45ecc33ff7d1b9ce4e7670ceeac504ef"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/aterm"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "da658ebd911595b8c50cd3fac6e37b39f76754f8ec3e0a0bde2a407a904284ba"
  end

  deprecate! date: "2021-11-03", because: :unmaintained

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    ENV.deparallelize # Parallel builds don't work
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <aterm1.h>

      int main(int argc, char *argv[]) {
        ATerm bottomOfStack;
        ATinit(argc, argv, &bottomOfStack);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lATerm", "-o", "test"
    system "./test"
  end
end
