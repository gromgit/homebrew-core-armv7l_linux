class Dirac < Formula
  desc "General-purpose video codec aimed at a range of resolutions"
  homepage "https://sourceforge.net/projects/dirac/"
  url "https://downloads.sourceforge.net/project/dirac/dirac-codec/Dirac-1.0.2/dirac-1.0.2.tar.gz"
  mirror "https://launchpad.net/ubuntu/+archive/primary/+files/dirac_1.0.2.orig.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/d/dirac/dirac_1.0.2.orig.tar.gz"
  sha256 "816b16f18d235ff8ccd40d95fc5b4fad61ae47583e86607932929d70bf1f00fd"
  license any_of: ["MPL-1.1", "GPL-2.0-only", "LGPL-2.1-only"]

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dirac"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8aed7df575619a048a1eb5832ee1eae168be4a2820523df445f94a8b84aeb84d"
  end

  # First two patches: the only two commits in the upstream repo not in 1.0.2

  patch do
    url "https://gist.githubusercontent.com/mistydemeo/da8a53abcf057c58b498/raw/bde69c5f07d871542dcb24792110e29e6418d2a3/unititialized-memory.patch"
    sha256 "d5fcbb1b5c9f2f83935d71ebd312e98294121e579edbd7818e3865606da36e10"
  end

  patch do
    url "https://gist.githubusercontent.com/mistydemeo/e729c459525d0d6e9e2d/raw/d9ff69c944b8bde006eef27650c0af36f51479f5/dirac-gcc-fixes.patch"
    sha256 "52c40f2c8aec9174eba2345e6ba9689ced1b8f865c7ced23e7f7ee5fdd6502c3"
  end

  # HACK: the configure script, which assumes any compiler that
  # starts with "cl" is a Microsoft compiler
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/85fa66a9/dirac/1.0.2.patch"
    sha256 "8f77a8f088b7054855e18391a4baa5c085da0f418f203c3e47aad7b63d84794a"
  end

  def install
    # BSD cp doesn't have '-d'
    inreplace "doc/Makefile.in", "cp -dR", "cp -R"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
