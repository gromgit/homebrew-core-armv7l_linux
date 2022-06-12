class Flvstreamer < Formula
  desc "Stream audio and video from flash & RTMP Servers"
  homepage "https://www.nongnu.org/flvstreamer/"
  url "https://download.savannah.gnu.org/releases/flvstreamer/source/flvstreamer-2.1c1.tar.gz"
  sha256 "e90e24e13a48c57b1be01e41c9a7ec41f59953cdb862b50cf3e667429394d1ee"
  license "GPL-2.0"

  livecheck do
    url "https://download.savannah.gnu.org/releases/flvstreamer/source/"
    regex(/href=.*?flvstreamer[._-]v?(\d+(?:\.\d+)+(?:[a-z]\d*)?)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/flvstreamer"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "4f56a8cc91b795d84159b3fa387ff3ea6d00fba7a115b45a9c989563d4658c11"
  end

  conflicts_with "rtmpdump", because: "both install 'rtmpsrv', 'rtmpsuck' and 'streams' binary"

  def install
    system "make", "posix"
    bin.install "flvstreamer", "rtmpsrv", "rtmpsuck", "streams"
  end

  test do
    system "#{bin}/flvstreamer", "-h"
  end
end
