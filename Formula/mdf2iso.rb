class Mdf2iso < Formula
  desc "Tool to convert MDF (Alcohol 120% images) images to ISO images"
  homepage "https://packages.debian.org/sid/mdf2iso"
  url "https://deb.debian.org/debian/pool/main/m/mdf2iso/mdf2iso_0.3.1.orig.tar.gz"
  sha256 "906f0583cb3d36c4d862da23837eebaaaa74033c6b0b6961f2475b946a71feb7"

  livecheck do
    skip "No longer developed or maintained"
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mdf2iso"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1035e20bdbe2d71c09dff2e750fce4fc756e9f0a7438818d550b6d67124c70a3"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mdf2iso --help")
  end
end
