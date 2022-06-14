class Libidn < Formula
  desc "International domain name library"
  homepage "https://www.gnu.org/software/libidn/"
  url "https://ftp.gnu.org/gnu/libidn/libidn-1.38.tar.gz"
  mirror "https://ftpmirror.gnu.org/libidn/libidn-1.38.tar.gz"
  sha256 "de00b840f757cd3bb14dd9a20d5936473235ddcba06d4bc2da804654b8bbf0f6"
  license any_of: ["GPL-2.0-or-later", "LGPL-3.0-or-later"]

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libidn"
    rebuild 1
    sha256 armv7l_linux: "6005a6b0bd3417c30af5d364c0b54af546abc02157ec9c8f76b2c413fa841806"
  end

  depends_on "pkg-config" => :build

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-csharp",
                          "--with-lispdir=#{elisp}"
    system "make", "install"
  end

  test do
    ENV["CHARSET"] = "UTF-8"
    system bin/"idn", "räksmörgås.se", "blåbærgrød.no"
  end
end
