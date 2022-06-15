class Libdmtx < Formula
  desc "Data Matrix library"
  homepage "https://libdmtx.sourceforge.io"
  url "https://github.com/dmtx/libdmtx/archive/v0.7.5.tar.gz"
  sha256 "be0c5275695a732a5f434ded1fcc232aa63b1a6015c00044fe87f3a689b75f2e"
  license "BSD-2-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libdmtx"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "75fdb78f61c17413d836442d2b1df12d9a5675e5d1a8a6d4e879989cbf27a562"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
