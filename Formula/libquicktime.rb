class Libquicktime < Formula
  desc "Library for reading and writing quicktime files"
  homepage "https://libquicktime.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/libquicktime/libquicktime/1.2.4/libquicktime-1.2.4.tar.gz"
  sha256 "1c53359c33b31347b4d7b00d3611463fe5e942cae3ec0fefe0d2fd413fd47368"
  revision 5

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libquicktime"
    sha256 armv7l_linux: "a0ed881d0e6acb59f431984dbc50059c4fedc46a9a91fb66c640ca0ad7fccc4e"
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"

  # Fix CVE-2016-2399. Applied upstream on March 6th 2017.
  # Also, fixes from upstream for CVE-2017-9122 through CVE-2017-9128, applied
  # by Debian since 30 Jun 2017.
  patch do
    url "https://deb.debian.org/debian/pool/main/libq/libquicktime/libquicktime_1.2.4-12.debian.tar.xz"
    sha256 "e5b5fa3ec8391b92554d04528568d04ea9eb5145835e0c246eac7961c891a91a"
    apply "patches/CVE-2016-2399.patch"
    apply "patches/CVE-2017-9122_et_al.patch"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-pre-0.4.2.418-big_sur.diff"
    sha256 "83af02f2aa2b746bb7225872cab29a253264be49db0ecebb12f841562d9a2923"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-gpl",
                          "--without-doxygen",
                          "--without-gtk",
                          "--without-x"
    system "make"
    system "make", "install"
  end

  test do
    fixture = test_fixtures("test.m4a")
    output = shell_output("#{bin}/qtinfo #{fixture} 2>&1")
    assert_match "length 1536 samples, compressor mp4a", output
    assert_predicate testpath/".libquicktime_codecs", :exist?
  end
end
