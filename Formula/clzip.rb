class Clzip < Formula
  desc "C language version of lzip"
  homepage "https://www.nongnu.org/lzip/clzip.html"
  url "https://download.savannah.gnu.org/releases/lzip/clzip/clzip-1.13.tar.gz"
  mirror "https://download-mirror.savannah.gnu.org/releases/lzip/clzip/clzip-1.13.tar.gz"
  sha256 "7ac9fbf5036bf50fb0b6a20e84d2293cb0d24d4044eaf33cbe9760bb9e7fea7a"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://download.savannah.gnu.org/releases/lzip/clzip/"
    regex(/href=.*?clzip[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/clzip"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f0486529045c356148b14658f030222c281912bb40c8e7f8c0884b23e93ef293"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
    pkgshare.install "testsuite"
  end

  test do
    cp_r pkgshare/"testsuite", testpath
    cd "testsuite" do
      ln_s bin/"clzip", "clzip"
      system "./check.sh"
    end
  end
end
