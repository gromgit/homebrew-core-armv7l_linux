class Ddrescue < Formula
  desc "GNU data recovery tool"
  homepage "https://www.gnu.org/software/ddrescue/ddrescue.html"
  url "https://ftp.gnu.org/gnu/ddrescue/ddrescue-1.26.tar.lz"
  mirror "https://ftpmirror.gnu.org/ddrescue/ddrescue-1.26.tar.lz"
  sha256 "e513cd3a90d9810dfdd91197d40aa40f6df01597bfb5ecfdfb205de1127c551f"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ddrescue"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c9a6e6a5ea872656a7958c62a66036cc996ecd840cbcd857a622f27d8a6e421f"
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "CXX=#{ENV.cxx}"
    system "make", "install"
  end

  test do
    system bin/"ddrescue", "--force", "--size=64Ki", "/dev/zero", "/dev/null"
  end
end
