class Psftools < Formula
  desc "Tools for fixed-width bitmap fonts"
  homepage "https://www.seasip.info/Unix/PSF/"
  # psftools-1.1.10.tar.gz (dated 2017) was a typo of 1.0.10 and has since been deleted.
  # You may still find it on some mirrors but it should not be used.
  url "https://www.seasip.info/Unix/PSF/psftools-1.0.14.tar.gz"
  sha256 "dcf8308fa414b486e6df7c48a2626e8dcb3c8a472c94ff04816ba95c6c51d19e"
  license "GPL-2.0"
  version_scheme 1

  # The development release on the homepage uses the same filename format as
  # the stable release (e.g., psftools-1.1.1.tar.gz). However, the "Development
  # Release" section comes before the "Stable Release" section, so we can use
  # this heading to anchor stable releases for now.
  livecheck do
    url :homepage
    regex(/Stable Release.+?href=.*?psftools[._-]v?(\d+(?:\.\d+)+)\.t/im)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/psftools"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "9b0e76bcd9476533459f714f347a870ad5c1a8874cca233835c7bff9692e4d1b"
  end

  # The `autoconf` dependency originates from 54cfae502ee4
  # which was meant to fix a bug in the `configure` script.
  # We add `automake` and `libtool` to run `autoreconf` to
  # work around the `-flat_namespace` bug. Our usual patches
  # don't work here because the install method called `autoconf`.
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  resource "pc8x8font" do
    url "https://www.zone38.net/font/pc8x8.zip"
    sha256 "13a17d57276e9ef5d9617b2d97aa0246cec9b2d4716e31b77d0708d54e5b978f"
  end

  def install
    # Regenerate `configure` to fix `-flat_namespace`.
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    # The zip file has a fon in it, use fon2fnts to extrat to fnt
    resource("pc8x8font").stage do
      system "#{bin}/fon2fnts", "pc8x8.fon"
      assert_predicate Pathname.pwd/"PC8X8_9.fnt", :exist?
    end
  end
end
