class Jpeginfo < Formula
  desc "Prints information and tests integrity of JPEG/JFIF files"
  homepage "https://www.kokkonen.net/tjko/projects.html"
  url "https://www.kokkonen.net/tjko/src/jpeginfo-1.6.1.tar.gz"
  sha256 "629e31cf1da0fa1efe4a7cc54c67123a68f5024f3d8e864a30457aeaed1d7653"
  license "GPL-2.0-or-later"
  revision 1
  head "https://github.com/tjko/jpeginfo.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?jpeginfo[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jpeginfo"
    rebuild 2
    sha256 cellar: :any_skip_relocation, armv7l_linux: "5bf2104332b3bee9d2ace9331438179084c0691878cc6ae4dca465989238dc75"
  end

  depends_on "autoconf" => :build
  depends_on "jpeg"

  def install
    ENV.deparallelize

    # The ./configure file inside the tarball is too old to work with Xcode 12, regenerate:
    system "autoconf", "--force"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/jpeginfo", "--help"
  end
end
