class Libyubikey < Formula
  desc "C library for manipulating Yubico one-time passwords"
  homepage "https://yubico.github.io/yubico-c/"
  url "https://developers.yubico.com/yubico-c/Releases/libyubikey-1.13.tar.gz"
  sha256 "04edd0eb09cb665a05d808c58e1985f25bb7c5254d2849f36a0658ffc51c3401"
  license "BSD-2-Clause"

  livecheck do
    url "https://developers.yubico.com/yubico-c/Releases/"
    regex(/href=.*?libyubikey[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libyubikey"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ac055f2c538d6179962e3f9a602a59bfcbf2eb68377b6f99c5e48e2594262844"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
