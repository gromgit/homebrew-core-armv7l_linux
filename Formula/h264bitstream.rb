class H264bitstream < Formula
  desc "Library for reading and writing H264 video streams"
  homepage "https://h264bitstream.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/h264bitstream/h264bitstream/0.2.0/h264bitstream-0.2.0.tar.gz"
  sha256 "94912cb07ef67da762be9c580b325fd8957ad400793c9030f3fb6565c6d263a7"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/h264bitstream"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "caf55d582cb7f812f37e24c92918365963edd8523678b0a6675f55b7b373a47a"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-iv"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
