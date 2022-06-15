class Optipng < Formula
  desc "PNG file optimizer"
  homepage "https://optipng.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-0.7.7/optipng-0.7.7.tar.gz"
  sha256 "4f32f233cef870b3f95d3ad6428bfe4224ef34908f1b42b0badf858216654452"
  license "Zlib"
  head "http://hg.code.sf.net/p/optipng/mercurial", using: :hg

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/optipng"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "74d0a73f237e0a394e01d7a81e9d9af53cca900b968a669bb4a7b26d4bd4ab89"
  end

  depends_on "libpng"

  uses_from_macos "zlib"

  def install
    system "./configure", "--with-system-zlib",
                          "--with-system-libpng",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/optipng", "-simulate", test_fixtures("test.png")
  end
end
