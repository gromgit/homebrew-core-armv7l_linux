class Asciitex < Formula
  desc "Generate ASCII-art representations of mathematical equations"
  homepage "https://asciitex.sourceforge.io"
  url "https://downloads.sourceforge.net/project/asciitex/asciiTeX-0.21.tar.gz"
  sha256 "abf964818833d8b256815eb107fb0de391d808fe131040fb13005988ff92a48d"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/asciitex"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "60e8252b704e826347fe4e10e3271c4451bea7bf4903fb8374dde667b3784f7c"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-gtk"
    inreplace "Makefile", "man/asciiTeX_gui.1", ""
    system "make", "install"
    pkgshare.install "EXAMPLES"
  end

  test do
    system "#{bin}/asciiTeX", "-f", "#{pkgshare}/EXAMPLES"
  end
end
