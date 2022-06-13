class Genext2fs < Formula
  desc "Generates an ext2 filesystem as a normal (non-root) user"
  homepage "https://genext2fs.sourceforge.io/"
  url "https://github.com/bestouff/genext2fs/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "d3861e4fe89131bd21fbd25cf0b683b727b5c030c4c336fadcd738ada830aab0"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/genext2fs"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "68ec709a1fb23b611d9379d46b3a7dd75a1fa2e61c38ed16151144f3bbbea452"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    rootpath = testpath/"img"
    (rootpath/"foo.txt").write "hello world"
    system "#{bin}/genext2fs", "--root", rootpath,
                               "--block-size", "4096",
                               "--size-in-blocks", "100",
                               "#{testpath}/test.img"
  end
end
