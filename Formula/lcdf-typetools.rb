class LcdfTypetools < Formula
  desc "Manipulate OpenType and multiple-master fonts"
  homepage "https://www.lcdf.org/type/"
  url "https://www.lcdf.org/type/lcdf-typetools-2.108.tar.gz"
  sha256 "fb09bf45d98fa9ab104687e58d6e8a6727c53937e451603662338a490cbbcb26"
  license "GPL-2.0-or-later"
  head "https://github.com/kohler/lcdf-typetools.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?lcdf-typetools[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/lcdf-typetools"
    sha256 armv7l_linux: "ffebadb9fd802f0a26955735b3bc15f3d661855d7e1a39bc570db803644c0ebb"
  end

  conflicts_with "texlive", because: "both install a `cfftot1` executable"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--without-kpathsea"
    system "make", "install"
  end

  test do
    if OS.mac?
      font_name = (MacOS.version >= :catalina) ? "Arial Unicode" : "Arial"
      font_dir = "/Library/Fonts"
    else
      font_name = "DejaVuSans"
      font_dir = "/usr/share/fonts/truetype/dejavu"
    end
    assert_includes shell_output("#{bin}/otfinfo -p '#{font_dir}/#{font_name}.ttf'"), font_name.delete(" ")
  end
end
