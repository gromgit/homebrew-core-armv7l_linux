class Id3lib < Formula
  desc "ID3 tag manipulation"
  homepage "https://id3lib.sourceforge.io/"
  revision 1
  head ":pserver:anonymous:@id3lib.cvs.sourceforge.net:/cvsroot/id3lib", using: :cvs, module: "id3lib-devel"

  stable do
    url "https://downloads.sourceforge.net/project/id3lib/id3lib/3.8.3/id3lib-3.8.3.tar.gz"
    sha256 "2749cc3c0cd7280b299518b1ddf5a5bcfe2d1100614519b68702230e26c7d079"

    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/e223e971/id3lib/id3lib-vbr-overflow.patch"
      sha256 "0ec91c9d89d80f40983c04147211ced8b4a4d8a5be207fbe631f5eefbbd185c2"
    end

    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/e223e971/id3lib/id3lib-main.patch"
      sha256 "83c8d2fa54e8f88b682402b2a8730dcbcc8a7578681301a6c034fd53e1275463"
    end
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/id3lib"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "33472ea5858e1b39c9be4e1ca153d54c5a26a15db669ba1cbce71a58dad352d0"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  uses_from_macos "zlib"

  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/e223e971/id3lib/no-iomanip.h.patch"
    sha256 "da0bd9f3d17f1dd054720c17dfd15062eabdfc4d38126bb1b2ef5e8f39904925"
  end

  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/e223e971/id3lib/automake.patch"
    sha256 "c1ae2aa04baee7f92301cbed120340682e62e1f839bb61f8f6d3c459a7faf097"
  end

  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/e223e971/id3lib/boolcheck.patch"
    sha256 "a7881dc25665f284798934ba19092d1eb45ca515a34e5c473accd144aa1a215a"
  end

  # fixes Unicode display problem in easytag: see Homebrew/homebrew-x11#123
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/e223e971/id3lib/patch_id3lib_3.8.3_UTF16_writing_bug.diff"
    sha256 "71c79002d9485965a3a93e87ecbd7fed8f89f64340433b7ccd263d21385ac969"
  end

  patch :DATA

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

__END__
--- a/include/id3/id3lib_strings.h
+++ b/include/id3/id3lib_strings.h
@@ -30,6 +30,7 @@
 #define _ID3LIB_STRINGS_H_

 #include <string>
+#include <cstring>

 #if (defined(__GNUC__) && (__GNUC__ >= 3) || (defined(_MSC_VER) && _MSC_VER > 1000))
 namespace std
--- a/include/id3/writers.h
+++ b/include/id3/writers.h
@@ -30,7 +30,7 @@

 #include "id3/writer.h"
 #include "id3/id3lib_streams.h"
-//#include <string.h>
+#include <cstring>

 class ID3_CPP_EXPORT ID3_OStreamWriter : public ID3_Writer
 {
