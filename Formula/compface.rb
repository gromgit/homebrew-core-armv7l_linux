class Compface < Formula
  desc "Convert to and from the X-Face format"
  homepage "https://web.archive.org/web/20170720045032/freecode.com/projects/compface"
  url "https://mirrorservice.org/sites/ftp.xemacs.org/pub/xemacs/aux/compface-1.5.2.tar.gz"
  mirror "https://ftp.heanet.ie/mirrors/ftp.xemacs.org/aux/compface-1.5.2.tar.gz"
  mirror "https://ftp.osuosl.org/pub/blfs/conglomeration/compface/compface-1.5.2.tar.gz"
  sha256 "a6998245f530217b800f33e01656be8d1f0445632295afa100e5c1611e4f6825"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/compface"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e5409f7892d6bfb2ebcb857d2310ba364c81946054adc710de096ac4187fe2ba"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"

    system "make", "install"
  end

  test do
    system bin/"uncompface"
  end
end
