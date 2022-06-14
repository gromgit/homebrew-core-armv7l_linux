class Jp2a < Formula
  desc "Convert JPG images to ASCII"
  homepage "https://csl.name/jp2a/"
  # Do not change source from SourceForge to GitHub until this issue is resolved:
  # https://github.com/cslarsen/jp2a/issues/8
  # Currently, GitHub only has jp2a v1.0.7, which is broken as described above.
  # jp2a v1.0.6 is stable, but it is only available on SourceForge, not GitHub.
  url "https://downloads.sourceforge.net/project/jp2a/jp2a/1.0.6/jp2a-1.0.6.tar.gz"
  sha256 "0930ac8a9545c8a8a65dd30ff80b1ae0d3b603f2ef83b04226da0475c7ccce1c"
  license "GPL-2.0"
  revision 1
  version_scheme 1

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jp2a"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a5cbe5a096936d1da601c5f1e2764bd64c764535291de2b251e96c7f8f8ead3f"
  end

  depends_on "jpeg"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"jp2a", test_fixtures("test.jpg")
  end
end
