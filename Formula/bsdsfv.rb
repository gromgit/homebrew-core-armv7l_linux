class Bsdsfv < Formula
  desc "SFV utility tools"
  homepage "https://bsdsfv.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/bsdsfv/bsdsfv/1.18/bsdsfv-1.18.tar.gz"
  sha256 "577245da123d1ea95266c1628e66a6cf87b8046e1a902ddd408671baecf88495"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bsdsfv"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "180b0be9400d823c7388d3193832e96c3ff2e1d83aa0c1a0efd2c244c1ebfe67"
  end

  # bug report:
  # https://sourceforge.net/p/bsdsfv/bugs/1/
  # Patch from MacPorts
  patch :DATA

  def install
    bin.mkpath

    inreplace "Makefile" do |s|
      s.change_make_var! "INSTALL_PREFIX", prefix
      s.change_make_var! "INDENT", "indent"
      s.gsub! "	${INSTALL_PROGRAM} bsdsfv ${INSTALL_PREFIX}/bin", "	${INSTALL_PROGRAM} bsdsfv #{bin}/"
    end

    system "make", "all"
    system "make", "install"
  end
end

__END__
--- a/bsdsfv.c	2012-09-25 07:31:03.000000000 -0500
+++ b/bsdsfv.c	2012-09-25 07:31:08.000000000 -0500
@@ -44,5 +44,5 @@
 typedef struct sfvtable {
	char filename[FNAMELEN];
-	int crc;
+	unsigned int crc;
	int found;
 } SFVTABLE;
