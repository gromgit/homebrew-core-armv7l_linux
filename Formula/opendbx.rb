class Opendbx < Formula
  desc "Lightweight but extensible database access library in C"
  homepage "https://linuxnetworks.de/doc/index.php/OpenDBX"
  url "https://linuxnetworks.de/opendbx/download/opendbx-1.4.6.tar.gz"
  sha256 "2246a03812c7d90f10194ad01c2213a7646e383000a800277c6fb8d2bf81497c"
  license "LGPL-2.0-or-later"
  revision 2

  # The download page includes a `libopendbx` development release, so we use a
  # leading forward slash to only match `opendbx` versions.
  livecheck do
    url "https://linuxnetworks.de/doc/index.php?title=OpenDBX/Download"
    regex(%r{href=.*?/opendbx[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/opendbx"
    sha256 armv7l_linux: "20e4453379672dfabef67ebee744f24c1a2f4cb5443227dfcaa633ff45fbb0ad"
  end

  depends_on "readline"
  depends_on "sqlite"

  def install
    # Reported upstream: http://bugs.linuxnetworks.de/index.php?do=details&id=40
    inreplace "utils/Makefile.in", "$(LIBSUFFIX)", ".dylib" if OS.mac?

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-backends=sqlite3"
    system "make"
    system "make", "install"
  end

  test do
    testfile = testpath/"test.sql"
    testfile.write <<~EOS
      create table t(x);
      insert into t values("Hello");
      .header
      select * from t;
      .quit
    EOS

    assert_match '"Hello"',
      pipe_output("#{bin}/odbx-sql odbx-sql -h ./ -d test.sqlite3 -b sqlite3", (testpath/"test.sql").read)
  end
end
