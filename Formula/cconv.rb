class Cconv < Formula
  desc "Iconv based simplified-traditional Chinese conversion tool"
  homepage "https://github.com/xiaoyjy/cconv"
  url "https://github.com/xiaoyjy/cconv/archive/v0.6.3.tar.gz"
  sha256 "82f46a94829f5a8157d6f686e302ff5710108931973e133d6e19593061b81d84"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cconv"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "fce215745d74ae68acf21eeab379582a23a07217a6d7c722a309e6533cf44bcf"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    ENV.append "LDFLAGS", "-liconv" if OS.mac?

    system "autoreconf", "-fvi"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
    rm_f include/"unicode.h"
  end

  test do
    encodings = "GB2312, GBK, GB-HANS, GB-HANT, GB18030, BIG5, UTF8, UTF8-CN, UTF8-TW, UTF8-HK"
    assert_match encodings, shell_output("#{bin}/cconv -l")
  end
end
