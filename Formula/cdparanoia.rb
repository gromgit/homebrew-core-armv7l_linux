class Cdparanoia < Formula
  desc "Audio extraction tool for sampling CDs"
  homepage "https://www.xiph.org/paranoia/"
  url "https://downloads.xiph.org/releases/cdparanoia/cdparanoia-III-10.2.src.tgz", using: :homebrew_curl
  mirror "https://ftp.osuosl.org/pub/xiph/releases/cdparanoia/cdparanoia-III-10.2.src.tgz"
  sha256 "005db45ef4ee017f5c32ec124f913a0546e77014266c6a1c50df902a55fe64df"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]

  livecheck do
    url "https://ftp.osuosl.org/pub/xiph/releases/cdparanoia/?C=M&O=D"
    regex(/href=.*?cdparanoia-III[._-]v?(\d+(?:\.\d+)+)\.src\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cdparanoia"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c0e2c3884ebfbbd98ccffcfeac83fd9330f5451febd4f50eddb5e03569a047df"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  # Patches via MacPorts
  on_macos do
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/2a22152/cdparanoia/osx_interface.patch"
      sha256 "3eca8ff34d2617c460056f97457b5ac62db1983517525e5c73886a2dea9f06d9"
    end
  end

  on_linux do
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/bfad134/cdparanoia/linux_fpic.patch"
      sha256 "496f53d21dde7e23f4c9cf1cc28219efcbb5464fe2abbd5a073635279281c9c4"
    end
  end

  def install
    ENV.deparallelize

    # Libs are installed as keg-only because most software that searches for cdparanoia
    # will fail to link against it cleanly due to our patches
    # RPATH to libexec on Linux must be added so that the linker can find keg-only libraries.
    unless OS.mac?
      ENV.append "LDFLAGS", "-Wl,-rpath,#{libexec}"
      inreplace "paranoia/Makefile.in",
                "-L ../interface",
                "-Wl,-rpath,#{Formula["cdparanoia"].libexec} -L ../interface"
    end

    system "autoreconf", "-fiv"
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--libdir=#{libexec}"
    system "make", "all"
    system "make", "install"
  end

  test do
    system "#{bin}/cdparanoia", "--version"
  end
end
