class LinuxHeadersAT415 < Formula
  desc "Header files of the Linux kernel"
  homepage "https://kernel.org/"
  url "https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.15.18.tar.gz"
  sha256 "ca13fa5c6e3a6b434556530d92bc1fc86532c2f4f5ae0ed766f6b709322d6495"
  license "GPL-2.0-only"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/linux-headers@4.15"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "31d0456e7ad1ea21a0dfbbde39dcadeb65427ea8419024481a25fff137a77ef2"
  end
  keg_only :versioned_formula

  depends_on :linux

  def install
    system "make", "headers_install", "INSTALL_HDR_PATH=#{prefix}"
    rm Dir[prefix/"**/{.install,..install.cmd}"]
  end

  test do
    assert_match "KERNEL_VERSION", File.read(include/"linux/version.h")
  end
end
