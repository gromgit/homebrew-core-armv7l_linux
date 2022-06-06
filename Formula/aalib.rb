class Aalib < Formula
  desc "Portable ASCII art graphics library"
  homepage "https://aa-project.sourceforge.io/aalib/"
  url "https://downloads.sourceforge.net/project/aa-project/aa-lib/1.4rc5/aalib-1.4rc5.tar.gz"
  sha256 "fbddda9230cf6ee2a4f5706b4b11e2190ae45f5eda1f0409dc4f99b35e0a70ee"
  license "GPL-2.0-or-later"
  revision 2

  # The latest version in the formula is a release candidate, so we have to
  # allow matching of unstable versions.
  livecheck do
    url :stable
    regex(%r{url=.*?/aalib[._-]v?(\d+(?:\.\d+)+.*?)\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/aalib"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "dc81f8af11d4a21777315d45d0b6e772d975d2dd0d83ffb78314f47f09915c08"
  end

  # Fix malloc/stdlib issue on macOS
  # Fix underquoted definition of AM_PATH_AALIB in aalib.m4
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/6e23dfb/aalib/1.4rc5.patch"
    sha256 "54aeff2adaea53902afc2660afb9534675b3ea522c767cbc24a5281080457b2c"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}",
                          "--enable-shared=yes",
                          "--enable-static=yes",
                          "--without-x"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/aainfo -width 100 -height 50")
    assert_match "AAlib version:#{version.major_minor}", output
    assert_match(/Width +:100$/, output)
    assert_match(/Height +:50$/, output)

    output = shell_output("yes '' | #{bin}/aatest -width 20 -height 10")
    assert_match <<~EOS, output
      floyd-steelberg dith
      ering. . ....----:.:
          . .......-.:.:::
         . . . ....---:-::
          . .......-.:.:-:
         . . . ....--.:-::
          . .......-.:-:-:
         . . . ....:.:.:-:
          . ........:.:-::
         . . . ....:.--:-:
    EOS
  end
end
