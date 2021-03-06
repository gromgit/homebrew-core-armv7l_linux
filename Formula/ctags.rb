class Ctags < Formula
  desc "Reimplementation of ctags(1)"
  homepage "https://ctags.sourceforge.io/"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]
  revision 2

  stable do
    url "https://downloads.sourceforge.net/project/ctags/ctags/5.8/ctags-5.8.tar.gz"
    sha256 "0e44b45dcabe969e0bbbb11e30c246f81abe5d32012db37395eb57d66e9e99c7"

    # also fixes https://sourceforge.net/p/ctags/bugs/312/
    # merged upstream but not yet in stable
    patch :p2 do
      url "https://gist.githubusercontent.com/naegelejd/9a0f3af61954ae5a77e7/raw/16d981a3d99628994ef0f73848b6beffc70b5db8/Ctags%20r782"
      sha256 "26d196a75fa73aae6a9041c1cb91aca2ad9d9c1de8192fce8cdc60e4aaadbcbb"
    end
  end

  livecheck do
    url :stable
    regex(%r{url=.*?/ctags[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ctags"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7f2c1e3f35fbd1c5538d5816f771c9c6b7e284eda8c711b12b5fc5edc13e408c"
  end

  head do
    url "https://svn.code.sf.net/p/ctags/code/trunk"
    depends_on "autoconf" => :build
  end

  conflicts_with "universal-ctags", because: "this formula installs the same executable as the ctags formula"

  # fixes https://sourceforge.net/p/ctags/bugs/312/
  patch :p2 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/85fa66a9/ctags/5.8.patch"
    sha256 "9b5b04d2b30d27abe71094b4b9236d60482059e479aefec799f0e5ace0f153cb"
  end

  def install
    if build.head?
      system "autoheader"
      system "autoconf"
    end

    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    system "./configure", "--prefix=#{prefix}",
                          "--enable-macro-patterns",
                          "--mandir=#{man}",
                          "--with-readlib"
    system "make", "install"
  end

  def caveats
    <<~EOS
      Under some circumstances, emacs and ctags can conflict. By default,
      emacs provides an executable `ctags` that would conflict with the
      executable of the same name that ctags provides. To prevent this,
      Homebrew removes the emacs `ctags` and its manpage before linking.
    EOS
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
    system "#{bin}/ctags", "-R", "."
    assert_match(/func.*test\.c/, File.read("tags"))
    assert_match "+regex", shell_output("ctags --version")
  end
end
