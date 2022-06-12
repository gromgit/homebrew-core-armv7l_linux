class Dcfldd < Formula
  desc "Enhanced version of dd for forensics and security"
  homepage "https://dcfldd.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/dcfldd/dcfldd/1.3.4-1/dcfldd-1.3.4-1.tar.gz"
  sha256 "f5143a184da56fd5ac729d6d8cbcf9f5da8e1cf4604aa9fb97c59553b7e6d5f8"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dcfldd"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "11a206fc2ca138d1c7ba1c05df8fc0e69567a0b78f77c5adcfd7f984c197f7c8"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/dcfldd", "--version"
  end
end
