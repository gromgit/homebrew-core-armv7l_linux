class Cgvg < Formula
  desc "Command-line source browsing tool"
  homepage "https://uzix.org/cgvg.html"
  url "https://uzix.org/cgvg/cgvg-1.6.3.tar.gz"
  sha256 "d879f541abcc988841a8d86f0c0781ded6e70498a63c9befdd52baf4649a12f3"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?cgvg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cgvg"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "57907efecbccd7eb40e8ab42da791682eebdb3d9bb9efa3d93312d2ef364ee3c"
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    (testpath/"test").write "Homebrew"
    assert_match "1 Homebrew", shell_output("#{bin}/cg Homebrew '#{testpath}/test'")
  end
end
