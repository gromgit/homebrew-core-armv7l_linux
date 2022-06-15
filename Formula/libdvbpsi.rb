class Libdvbpsi < Formula
  desc "Library to decode/generate MPEG TS and DVB PSI tables"
  homepage "https://www.videolan.org/developers/libdvbpsi.html"
  url "https://download.videolan.org/pub/libdvbpsi/1.3.3/libdvbpsi-1.3.3.tar.bz2"
  sha256 "02b5998bcf289cdfbd8757bedd5987e681309b0a25b3ffe6cebae599f7a00112"
  license "LGPL-2.1"

  livecheck do
    url "https://download.videolan.org/pub/libdvbpsi/"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libdvbpsi"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "6164afcfd5a521d520099d0cad38fcdb62a8f0484556d234b465f02d11310c3a"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking", "--enable-release"
    system "make", "install"
  end
end
