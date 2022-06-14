class Kstart < Formula
  desc "Modified version of kinit that can use keytabs to authenticate"
  homepage "https://www.eyrie.org/~eagle/software/kstart/"
  url "https://archives.eyrie.org/software/kerberos/kstart-4.3.tar.xz"
  sha256 "7a3388ae79927c6698dc1bf20b29717e6bc34f692e00f12b3369d896f6702060"

  livecheck do
    url :homepage
    regex(/href=.*?kstart[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/kstart"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "cf5445d0562ea80732e75ccce7e2d6ff3049e1165c2d171036a1a5fd0ca4bb5e"
  end

  uses_from_macos "krb5"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/k5start", "-h"
  end
end
