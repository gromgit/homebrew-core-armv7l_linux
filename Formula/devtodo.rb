class Devtodo < Formula
  desc "Command-line task lists"
  homepage "https://swapoff.org/devtodo.html"
  url "https://swapoff.org/files/devtodo/devtodo-0.1.20.tar.gz"
  sha256 "379c6ac4499fc97e9676075188f7217e324e7ece3fb6daeda7bf7969c7093e09"
  revision 2

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/devtodo"
    sha256 armv7l_linux: "d7e2e4f82fc0d4bfd81bec4368d296230d96a19b99a446f3acaa1f13f87f7701"
  end

  depends_on "readline"

  conflicts_with "todoman", because: "both install a `todo` binary"

  # Fix invalid regex. See https://web.archive.org/web/20090205000308/swapoff.org/ticket/54
  patch :DATA

  def install
    # Rename Regex.h to Regex.hh to avoid case-sensitivity confusion with regex.h
    mv "util/Regex.h", "util/Regex.hh"
    inreplace ["util/Lexer.h", "util/Makefile.in", "util/Regex.cc"],
      "Regex.h", "Regex.hh"

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
    doc.install "contrib"
  end

  test do
    (testpath/"test").write <<~EOS
      spawn #{bin}/devtodo --add HomebrewWork
      expect "priority*"
      send -- "2\r"
      expect eof
    EOS
    system "expect", "-f", "test"
    assert_match "HomebrewWork", (testpath/".todo").read
  end
end

__END__
--- a/util/XML.cc	Mon Dec 10 22:26:55 2007
+++ b/util/XML.cc	Mon Dec 10 22:27:07 2007
@@ -49,7 +49,7 @@ void XML::init() {
 	// Only initialise scanners once
 	if (!initialised) {
 		// <?xml version="1.0" encoding="UTF-8" standalone="no"?>
-		xmlScan.addPattern(XmlDecl, "<\\?xml.*?>[[:space:]]*");
+		xmlScan.addPattern(XmlDecl, "<\\?xml.*\\?>[[:space:]]*");
 		xmlScan.addPattern(XmlCommentBegin, "<!--");
 		xmlScan.addPattern(XmlBegin, "<[a-zA-Z0-9_-]+"
 			"([[:space:]]+[a-zA-Z_0-9-]+=(([/a-zA-Z_0-9,.]+)|(\"[^\"]*\")|('[^']*')))"
