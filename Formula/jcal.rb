class Jcal < Formula
  desc "UNIX-cal-like tool to display Jalali calendar"
  homepage "https://savannah.nongnu.org/projects/jcal/"
  url "https://download.savannah.gnu.org/releases/jcal/jcal-0.4.1.tar.gz"
  sha256 "e8983ecad029b1007edc98458ad13cd9aa263d4d1cf44a97e0a69ff778900caa"
  license "GPL-3.0"

  livecheck do
    url "https://download.savannah.gnu.org/releases/jcal/"
    regex(/href=.*?jcal[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jcal"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "752a4422110e63e4621462cbf7f41c13a075293d7a2edae105bed5b5c4b35c4b"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    shell_name = OS.mac? ? "/bin/sh" : "/bin/bash"
    system shell_name, "autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/jcal", "-y"
    system "#{bin}/jdate"
  end
end
