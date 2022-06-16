class Rarian < Formula
  desc "Documentation metadata library"
  homepage "https://rarian.freedesktop.org/"
  url "https://rarian.freedesktop.org/Releases/rarian-0.8.1.tar.bz2"
  sha256 "aafe886d46e467eb3414e91fa9e42955bd4b618c3e19c42c773026b205a84577"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://rarian.freedesktop.org/Releases/"
    regex(/href=.*?rarian[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/rarian"
    sha256 armv7l_linux: "5c0d94af741e548386726641a59f3354e34feae006885758381ecf99a18daab7"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  conflicts_with "scrollkeeper",
    because: "rarian and scrollkeeper install the same binaries"

  def install
    # Regenerate `configure` to fix `-flat_namespace` bug.
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    seriesid1 = shell_output(bin/"rarian-sk-gen-uuid").strip
    sleep 5
    seriesid2 = shell_output(bin/"rarian-sk-gen-uuid").strip
    assert_match(/^\h+(?:-\h+)+$/, seriesid1)
    assert_match(/^\h+(?:-\h+)+$/, seriesid2)
    refute_equal seriesid1, seriesid2
  end
end
