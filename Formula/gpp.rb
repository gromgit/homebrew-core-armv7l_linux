class Gpp < Formula
  desc "General-purpose preprocessor with customizable syntax"
  homepage "https://logological.org/gpp"
  url "https://files.nothingisreal.com/software/gpp/gpp-2.27.tar.bz2"
  sha256 "49eb99d22af991e7f4efe2b21baa1196e9ab98c05b4b7ed56524a612c47b8fd3"
  license "GPL-3.0"

  livecheck do
    url "https://github.com/logological/gpp.git"
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gpp"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "98a84b179fe18673e259ce36c2103ada518d2a10bf709b6e5a6acf4d8cb12259"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--mandir=#{man}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    system "#{bin}/gpp", "--version"
  end
end
