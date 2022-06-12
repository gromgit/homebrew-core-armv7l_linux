class Cscope < Formula
  desc "Tool for browsing source code"
  homepage "https://cscope.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/cscope/cscope/v15.9/cscope-15.9.tar.gz"
  sha256 "c5505ae075a871a9cd8d9801859b0ff1c09782075df281c72c23e72115d9f159"

  livecheck do
    url :stable
    regex(%r{url=.*?/cscope[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cscope"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3eff83b5cd7f9d7c1fada9f84520a6c6d2d619b68796598327077e60f0586718"
  end

  uses_from_macos "ncurses"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <stdlib.h>

      void func()
      {
        printf("Hello World!");
      }

      int main()
      {
        func();
        return 0;
      }
    EOS
    (testpath/"cscope.files").write "./test.c\n"
    system "#{bin}/cscope", "-b", "-k"
    assert_match(/test\.c.*func/, shell_output("#{bin}/cscope -L1func"))
  end
end
