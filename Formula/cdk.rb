class Cdk < Formula
  desc "Curses development kit provides predefined curses widget for apps"
  homepage "https://invisible-island.net/cdk/"
  url "https://invisible-mirror.net/archives/cdk/cdk-5.0-20211216.tgz"
  sha256 "aeec4d9be2255970c8dca0785a0a996f0d242eb4f73cf927a3ec04997a3e63e8"
  license "BSD-4-Clause-UC"

  livecheck do
    url "https://invisible-mirror.net/archives/cdk/"
    regex(/href=.*?cdk[._-]v?(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cdk"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8168efa321afec2ab0a9a093e7a7081f222518e1d3e85b58cd42f52b2501b044"
  end

  uses_from_macos "ncurses"

  def install
    system "./configure", "--prefix=#{prefix}", "--with-ncurses"
    system "make", "install"
  end

  test do
    assert_match lib.to_s, shell_output("#{bin}/cdk5-config --libdir")
  end
end
