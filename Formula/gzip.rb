class Gzip < Formula
  desc "Popular GNU data compression program"
  homepage "https://www.gnu.org/software/gzip"
  url "https://ftp.gnu.org/gnu/gzip/gzip-1.12.tar.gz"
  mirror "https://ftpmirror.gnu.org/gzip/gzip-1.12.tar.gz"
  sha256 "5b4fb14d38314e09f2fc8a1c510e7cd540a3ea0e3eb9b0420046b82c3bf41085"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gzip"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "abf504481c347cb542cb8e7ae1b61107d84e3741d8a7bc41493dd7898c3d00de"
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"foo").write "test"
    system "#{bin}/gzip", "foo"
    system "#{bin}/gzip", "-t", "foo.gz"
    assert_equal "test", shell_output("#{bin}/gunzip -c foo")
  end
end
