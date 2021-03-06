class Jbigkit < Formula
  desc "JBIG1 data compression standard implementation"
  homepage "https://www.cl.cam.ac.uk/~mgk25/jbigkit/"
  url "https://www.cl.cam.ac.uk/~mgk25/jbigkit/download/jbigkit-2.1.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/j/jbigkit/jbigkit_2.1.orig.tar.gz"
  sha256 "de7106b6bfaf495d6865c7dd7ac6ca1381bd12e0d81405ea81e7f2167263d932"
  license "GPL-2.0"
  head "https://www.cl.cam.ac.uk/~mgk25/git/jbigkit", using: :git, branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?jbigkit[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jbigkit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "69d9c4b9f0512deb81739bf0a4eb2aa045a8276f314ea4d5eb6068e09b5c6cee"
  end

  conflicts_with "netpbm", because: "both install `pbm.5` and `pgm.5` files"

  def install
    system "make", "CC=#{ENV.cc}", "CCFLAGS=#{ENV.cflags}"

    cd "pbmtools" do
      bin.install %w[pbmtojbg jbgtopbm pbmtojbg85 jbgtopbm85]
      man1.install %w[pbmtojbg.1 jbgtopbm.1]
      man5.install %w[pbm.5 pgm.5]
    end
    cd "libjbig" do
      lib.install Dir["lib*.a"]
      (prefix/"src").install Dir["j*.c", "j*.txt"]
      include.install Dir["j*.h"]
    end
    pkgshare.install "examples", "contrib"
  end

  test do
    system "#{bin}/jbgtopbm #{pkgshare}/examples/ccitt7.jbg | #{bin}/pbmtojbg - testoutput.jbg"
    system "/usr/bin/cmp", pkgshare/"examples/ccitt7.jbg", "testoutput.jbg"
  end
end
