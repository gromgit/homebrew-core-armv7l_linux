class Iprint < Formula
  desc "Provides a print_one function"
  homepage "https://www.samba.org/ftp/unpacked/junkcode/i.c"
  url "https://deb.debian.org/debian/pool/main/i/iprint/iprint_1.3.orig.tar.gz"
  version "1.3-9"
  sha256 "1079b2b68f4199bc286ed08abba3ee326ce3b4d346bdf77a7b9a5d5759c243a3"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/iprint"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "cba0784a1677df508f57a018fc27b26ce7c70b6206f2de403703872ad77d271b"
  end

  patch do
    url "https://deb.debian.org/debian/pool/main/i/iprint/iprint_1.3-9.diff.gz"
    sha256 "3a1ff260e6d639886c005ece754c2c661c0d3ad7f1f127ddb2943c092e18ab74"
  end

  def install
    system "make"
    bin.install "i"
    man1.install "i.1"
  end

  test do
    assert_equal shell_output("#{bin}/i 1234"), "1234 0x4D2 02322 0b10011010010\n"
  end
end
