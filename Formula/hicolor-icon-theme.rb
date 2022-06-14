class HicolorIconTheme < Formula
  desc "Fallback theme for FreeDesktop.org icon themes"
  homepage "https://wiki.freedesktop.org/www/Software/icon-theme/"
  url "https://icon-theme.freedesktop.org/releases/hicolor-icon-theme-0.17.tar.xz"
  sha256 "317484352271d18cbbcfac3868eab798d67fff1b8402e740baa6ff41d588a9d8"
  license all_of: ["FSFUL", "FSFULLR", "GPL-2.0-only", "X11"]

  livecheck do
    url :homepage
    regex(/href=.*?hicolor-icon-theme[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/hicolor-icon-theme"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "fca72dd306b23edae0d4d66b0bd485e66f53f175ba1ca87a6167309d73533bc8"
  end

  head do
    url "https://gitlab.freedesktop.org/xdg/default-icon-theme.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    args = %W[--prefix=#{prefix} --disable-silent-rules]
    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end
    system "make", "install"
  end

  test do
    assert_predicate share/"icons/hicolor/index.theme", :exist?
  end
end
