class Datamash < Formula
  desc "Tool to perform numerical, textual & statistical operations"
  homepage "https://www.gnu.org/software/datamash"
  url "https://ftp.gnu.org/gnu/datamash/datamash-1.7.tar.gz"
  mirror "https://ftpmirror.gnu.org/datamash/datamash-1.7.tar.gz"
  sha256 "574a592bb90c5ae702ffaed1b59498d5e3e7466a8abf8530c5f2f3f11fa4adb3"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/datamash"
    sha256 armv7l_linux: "4fc976499d72ee97d20e9fc6c41f9a86d449434692eb90d879eca1e8f910cdf0"
  end

  head do
    url "https://git.savannah.gnu.org/git/datamash.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
  end

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "55", pipe_output("#{bin}/datamash sum 1", shell_output("seq 10")).chomp
  end
end
