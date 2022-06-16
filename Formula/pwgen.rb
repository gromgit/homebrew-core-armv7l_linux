class Pwgen < Formula
  desc "Password generator"
  homepage "https://pwgen.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/pwgen/pwgen/2.08/pwgen-2.08.tar.gz"
  sha256 "dab03dd30ad5a58e578c5581241a6e87e184a18eb2c3b2e0fffa8a9cf105c97b"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pwgen"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "634aee248cf2d0bec4117ad8ec8be7cc247c4c5fd1240021a5c64d4a1033a3de"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/pwgen", "--secure", "20", "10"
  end
end
