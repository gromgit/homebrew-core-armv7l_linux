class Bashdb < Formula
  desc "Bash shell debugger"
  homepage "https://bashdb.sourceforge.io"
  url "https://downloads.sourceforge.net/project/bashdb/bashdb/5.0-1.1.2/bashdb-5.0-1.1.2.tar.bz2"
  version "5.0-1.1.2"
  sha256 "30176d2ad28c5b00b2e2d21c5ea1aef8fbaf40a8f9d9f723c67c60531f3b7330"
  license "GPL-2.0-or-later"

  # We check the "bashdb" directory page because the bashdb project contains
  # various software and bashdb releases may be pushed out of the SourceForge
  # RSS feed.
  livecheck do
    url "https://sourceforge.net/projects/bashdb/files/bashdb/"
    strategy :page_match
    regex(%r{href=(?:["']|.*?bashdb/)?v?(\d+(?:[.-]\d+)+)/?["' >]}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bashdb"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3a0450d4b16c3cd4d08aff8230286582a4f44cee5dfbd27168d1a97f0a436866"
  end

  depends_on "autoconf" => :build # due to patch
  depends_on "automake" => :build # due to patch
  depends_on "bash"

  # Bypass error with Bash 5.1: "error: This package is only known to work with Bash 5.0"
  # Upstream ref: https://sourceforge.net/p/bashdb/code/ci/6daffb5c7337620b429f5e94c282b75a0777fc82/
  patch :DATA

  def install
    system "autoreconf", "--verbose", "--install", "--force"
    system "./configure", "--with-bash=#{HOMEBREW_PREFIX}/bin/bash",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    assert_match version.to_s, pipe_output("#{bin}/bashdb --version 2>&1")
  end
end

__END__
--- a/configure.ac
+++ b/configure.ac
@@ -107,7 +107,7 @@
 [bash_minor=`$SH_PROG -c 'echo ${BASH_VERSINFO[1]}'`]
 bash_5_or_greater=no
 case "${bash_major}.${bash_minor}" in
-  'OK_BASH_VERS' | '5.0')
+  'OK_BASH_VERS' | '5.0' | '5.1')
     bash_5_or_greater=yes
     ;;
   *)
@@ -118,7 +118,8 @@

 AC_ARG_WITH(dbg-main, AC_HELP_STRING([--with-dbg-main],
                   [location of dbg-main.sh]),
-		  DBGR_MAIN=$withval)
+		  [DBGR_MAIN=$withval]
+		  [DBGR_MAIN=${ac_default_prefix/prefix}/bashdb/bashdb-main.inc])
 AC_SUBST(DBGR_MAIN)

 mydir=$(dirname $0)
