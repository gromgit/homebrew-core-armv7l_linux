class Nyancat < Formula
  desc "Renders an animated, color, ANSI-text loop of the Poptart Cat"
  homepage "https://github.com/klange/nyancat"
  url "https://github.com/klange/nyancat/archive/1.5.2.tar.gz"
  sha256 "88cdcaa9c7134503dd0364a97fa860da3381a09cb555c3aae9918360827c2032"
  license "NCSA"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/nyancat"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "015c0d3f858debe4f7fa3f27e1be6548d493b4e060e8b11e965d9b544be4bb28"
  end

  # Makefile: Add install directory option
  # See https://github.com/klange/nyancat/pull/34
  patch do
    url "https://github.com/klange/nyancat/commit/e11af77f2938ea851f712df62f08de4d369598d4.patch?full_index=1"
    sha256 "24a0772d2725e151b57727ce887f4b3911d19e875785eb7e13a68f4b987831e8"
  end

  def install
    system "make"
    system "make", "install", "instdir=#{prefix}"
  end

  test do
    system bin/"nyancat", "--frames", "1", "--width", "40", "--height", "20", "--no-clear"
  end
end
