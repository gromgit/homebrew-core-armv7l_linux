class Quotatool < Formula
  desc "Edit disk quotas from the command-line"
  homepage "https://quotatool.ekenberg.se/"
  url "https://quotatool.ekenberg.se/quotatool-1.6.2.tar.gz"
  sha256 "e53adc480d54ae873d160dc0e88d78095f95d9131e528749fd982245513ea090"
  license "GPL-2.0"

  livecheck do
    url "https://quotatool.ekenberg.se/index.php?node=download"
    regex(/href=.*?quotatool[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/quotatool"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "cf4734df796332b087b41f96eb3e60a47080ef5cb9298e2daa9719910b9c8b4c"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    sbin.mkpath
    man8.mkpath
    system "make", "install"
  end

  test do
    system "#{sbin}/quotatool", "-V"
  end
end
