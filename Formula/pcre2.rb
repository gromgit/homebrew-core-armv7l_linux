class Pcre2 < Formula
  desc "Perl compatible regular expressions library with a new API"
  homepage "https://www.pcre.org/"
  url "https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.40/pcre2-10.40.tar.bz2"
  sha256 "14e4b83c4783933dc17e964318e6324f7cae1bc75d8f3c79bc6969f00c159d68"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    regex(/^pcre2[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pcre2"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "14742dff04f4e09f9dbc8c4aff91269788af274d74949f97126c5ddd882dceae"
  end

  head do
    url "https://github.com/PCRE2Project/pcre2.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-pcre2-16
      --enable-pcre2-32
      --enable-pcre2grep-libz
      --enable-pcre2grep-libbz2
      --enable-jit
    ]

    args << "--enable-pcre2test-libedit" if OS.mac?

    system "./autogen.sh" if build.head?

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"pcre2grep", "regular expression", prefix/"README"
  end
end
