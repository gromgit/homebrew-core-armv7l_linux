class Adplug < Formula
  desc "Free, hardware independent AdLib sound player library"
  homepage "https://adplug.github.io"
  url "https://github.com/adplug/adplug/releases/download/adplug-2.3.3/adplug-2.3.3.tar.bz2"
  sha256 "a0f3c1b18fb49dea7ac3e8f820e091a663afa5410d3443612bf416cff29fa928"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/adplug"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d6ae95afc9e11ce8ba1f7d2c3061e4d78e20bc52ebb77dfa9f95ed5263f2d919"
  end

  depends_on "pkg-config" => :build
  depends_on "libbinio"

  resource "ksms" do
    url "http://advsys.net/ken/ksmsongs.zip"
    sha256 "2af9bfc390f545bc7f51b834e46eb0b989833b11058e812200d485a5591c5877"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    resource("ksms").stage do
      mkdir "#{testpath}/.adplug"
      system "#{bin}/adplugdb", "-v", "add", "JAZZSONG.KSM"
    end
  end
end
