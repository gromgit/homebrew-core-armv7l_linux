class Ekg2 < Formula
  desc "Multiplatform, multiprotocol, plugin-based instant messenger"
  homepage "https://github.com/ekg2/ekg2"
  url "https://src.fedoraproject.org/lookaside/extras/ekg2/ekg2-0.3.1.tar.gz/68fc05b432c34622df6561eaabef5a40/ekg2-0.3.1.tar.gz"
  mirror "https://web.archive.org/web/20161227025528/pl.ekg2.org/ekg2-0.3.1.tar.gz"
  sha256 "6ad360f8ca788d4f5baff226200f56922031ceda1ce0814e650fa4d877099c63"
  license "GPL-2.0"
  revision 4

  livecheck do
    url :homepage
    regex(/^ekg2[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ekg2"
    sha256 armv7l_linux: "ba9fe28ff31888e00aaf4fa86a88b33b3efe5e22873f09c6b79fc26306636253"
  end

  depends_on "pkg-config" => :build
  depends_on "openssl@1.1"
  depends_on "readline"

  # Fix the build on OS X 10.9+
  # bugs.ekg2.org/issues/152 [LOST LINK]
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/85fa66a9/ekg2/0.3.1.patch"
    sha256 "6efbb25e57581c56fe52cf7b70dbb9c91c9217525b402f0647db820df9a14daa"
  end

  # Upstream commit, fix build against OpenSSL 1.1
  patch do
    url "https://github.com/ekg2/ekg2/commit/f05815.patch?full_index=1"
    sha256 "207639edc5e6576c8a67301c63f0b28814d9885f0d4fca5d9d9fc465f4427cd7"
  end

  def install
    readline = Formula["readline"].opt_prefix

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-unicode
      --with-readline=#{readline}
      --without-gtk
      --without-libgadu
      --without-perl
      --without-python
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/ekg2", "--help"
  end
end
