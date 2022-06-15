class Libiptcdata < Formula
  desc "Virtual package provided by libiptcdata0"
  homepage "https://libiptcdata.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/libiptcdata/libiptcdata/1.0.4/libiptcdata-1.0.4.tar.gz"
  sha256 "79f63b8ce71ee45cefd34efbb66e39a22101443f4060809b8fc29c5eebdcee0e"
  revision 1

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libiptcdata"
    sha256 armv7l_linux: "f5dd2c5d2e733c9365bbc3afe620224d48d2160c60d4d3949c84785972eaa682"
  end

  depends_on "gettext"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
