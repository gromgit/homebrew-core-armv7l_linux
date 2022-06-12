class Flake < Formula
  desc "FLAC audio encoder"
  homepage "https://flake-enc.sourceforge.io"
  url "https://downloads.sourceforge.net/project/flake-enc/flake/0.11/flake-0.11.tar.bz2"
  sha256 "8dd249888005c2949cb4564f02b6badb34b2a0f408a7ec7ab01e11ceca1b7f19"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/flake"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "cf35883ace61162c661c52ae819a21a28637aca2e0102434d40f3ab68739f5ba"
  end

  def install
    ENV.deparallelize
    system "./configure", "--disable-debug", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"flake", test_fixtures("test.wav"), "-o", testpath/"test"
  end
end
