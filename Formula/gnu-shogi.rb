class GnuShogi < Formula
  desc "Japanese Chess"
  homepage "https://www.gnu.org/software/gnushogi/"
  url "https://ftp.gnu.org/gnu/gnushogi/gnushogi-1.4.2.tar.gz"
  mirror "https://ftpmirror.gnu.org/gnushogi/gnushogi-1.4.2.tar.gz"
  sha256 "1ecc48a866303c63652552b325d685e7ef5e9893244080291a61d96505d52b29"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gnu-shogi"
    rebuild 1
    sha256 armv7l_linux: "ce6b0102a0977355db72edc1b375ba371733097c668e28054b9e4145f85a3f47"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install", "MANDIR=#{man6}", "INFODIR=#{info}"
  end

  test do
    (testpath/"test").write <<~EOS
      7g7f
      exit
    EOS
    system "#{bin}/gnushogi < test"
  end
end
