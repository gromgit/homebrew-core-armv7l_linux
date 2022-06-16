class Qstat < Formula
  desc "Query Quake servers from the command-line"
  homepage "https://github.com/Unity-Technologies/qstat"
  url "https://github.com/Unity-Technologies/qstat/archive/v2.17.tar.gz"
  sha256 "ff0a050e867ad1d6fdf6b5d707e2fc7aea2826b8a382321220b390c621fb1562"
  license "Artistic-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/qstat"
    sha256 armv7l_linux: "efbef573ceae85b0ff304eb865459ffad3ffa314da34b541b4649420498f73c6"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoupdate" unless OS.mac?
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/qstat", "--help"
  end
end
