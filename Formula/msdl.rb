class Msdl < Formula
  desc "Downloader for various streaming protocols"
  homepage "https://msdl.sourceforge.io"
  url "https://downloads.sourceforge.net/project/msdl/msdl/msdl-1.2.7-r2/msdl-1.2.7-r2.tar.gz"
  version "1.2.7-r2"
  sha256 "0297e87bafcab885491b44f71476f5d5bfc648557e7d4ef36961d44dd430a3a1"
  license "GPL-3.0"

  livecheck do
    url :stable
    regex(%r{url=.*?/msdl[._-]v?(\d+(?:\.\d+)+(?:-r\d+)?)\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/msdl"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d2898b6282f19681d6c6e0c2446f2606c20289431e52ff9f689ea8822744b799"
  end

  # Fixes linker error under clang; apparently reported upstream:
  # https://github.com/Homebrew/homebrew/pull/13907
  patch :DATA

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

__END__
diff --git a/src/url.c b/src/url.c
index 81783c7..356883a 100644
--- a/src/url.c
+++ b/src/url.c
@@ -266,7 +266,7 @@ void url_unescape_string(char *dst,char *src)
 /*
  * return true if 'c' is valid url character
  */
-inline int is_url_valid_char(int c)
+int is_url_valid_char(int c)
 {
     return (isalpha(c) ||
	    isdigit(c) ||
