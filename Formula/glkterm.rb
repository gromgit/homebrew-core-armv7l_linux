class Glkterm < Formula
  desc "Terminal-window Glk library"
  homepage "https://www.eblong.com/zarf/glk/"
  url "https://www.eblong.com/zarf/glk/glkterm-104.tar.gz"
  version "1.0.4"
  sha256 "473d6ef74defdacade2ef0c3f26644383e8f73b4f1b348e37a9bb669a94d927e"

  livecheck do
    url :homepage
    regex(/href=.*?glkterm[._-]v?(?:\d+(?:\.\d+)*)\.t[^>]+?>\s*?GlkTerm library v?(\d+(?:\.\d+)+)/im)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/glkterm"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "42a1376039ba5883a9f782c5f5094616bec51346929d49143581498fcaaa1d09"
  end

  keg_only "conflicts with other Glk libraries"

  uses_from_macos "ncurses"

  def install
    system "make"

    lib.install "libglkterm.a"
    include.install "glk.h", "glkstart.h", "gi_blorb.h", "gi_dispa.h", "Make.glkterm"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "glk.h"
      #include "glkstart.h"

      glkunix_argumentlist_t glkunix_arguments[] = {
          { NULL, glkunix_arg_End, NULL }
      };

      int glkunix_startup_code(glkunix_startup_t *data)
      {
          return TRUE;
      }

      void glk_main()
      {
          glk_exit();
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lglkterm", "-lncurses", "-o", "test"
    system "echo test | ./test"
  end
end
