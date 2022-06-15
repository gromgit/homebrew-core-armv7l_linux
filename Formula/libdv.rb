class Libdv < Formula
  desc "Codec for DV video encoding format"
  homepage "https://libdv.sourceforge.io"
  url "https://downloads.sourceforge.net/project/libdv/libdv/1.0.0/libdv-1.0.0.tar.gz"
  sha256 "a305734033a9c25541a59e8dd1c254409953269ea7c710c39e540bd8853389ba"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libdv"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "410cf935672de707f928b9fb4350d17d70ebe4074d119fb35411e7ef2dfe9d86"
  end

  depends_on "popt"

  on_macos do
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "pkg-config" => :build
  end

  # remove SDL1 dependency by force
  patch :DATA

  def install
    if OS.mac?
      # This fixes an undefined symbol error on compile.
      # See the port file for libdv:
      #   https://trac.macports.org/browser/trunk/dports/multimedia/libdv/Portfile
      # This flag is the preferred method over what macports uses.
      # See the apple docs: https://cl.ly/2HeF bottom of the "Finding Imported Symbols" section
      ENV.append "LDFLAGS", "-undefined dynamic_lookup"
      system "autoreconf", "-fvi"
    end

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-gtktest",
                          "--disable-gtk",
                          "--disable-asm",
                          "--disable-sdltest"
    system "make", "install"
  end
end

__END__
diff --git a/configure.ac b/configure.ac
index 2b95735..1ba9370 100644
--- a/configure.ac
+++ b/configure.ac
@@ -173,13 +173,6 @@ dnl used in Makefile.am
 AC_SUBST(GTK_CFLAGS)
 AC_SUBST(GTK_LIBS)
 
-if $use_sdl; then
-	AM_PATH_SDL(1.1.6,
-	[
-		AC_DEFINE(HAVE_SDL) 
- 	])
-fi
-
 if [ $use_gtk && $use_xv ]; then
 	AC_CHECK_LIB(Xv, XvQueryAdaptors,
 		[AC_DEFINE(HAVE_LIBXV)
