class Htmldoc < Formula
  desc "Convert HTML to PDF or PostScript"
  homepage "https://www.msweet.org/htmldoc/"
  url "https://github.com/michaelrsweet/htmldoc/archive/v1.9.16.tar.gz"
  sha256 "f0d19d8be0fd961d07556f85dbea1d95f0d38728a45dc0f2cf92c715e4140542"
  license "GPL-2.0-only"
  head "https://github.com/michaelrsweet/htmldoc.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/htmldoc"
    sha256 armv7l_linux: "0b0493c880cb47b27bcf1ab91f9e7cd0ab8a4ae77e7c767c01e20b5e22bda13e"
  end

  depends_on "pkg-config" => :build
  depends_on "jpeg"
  depends_on "libpng"

  def install
    system "./configure", "--disable-debug",
                          "--disable-ssl",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/htmldoc", "--version"
  end
end
