class Httpry < Formula
  desc "Packet sniffer for displaying and logging HTTP traffic"
  homepage "https://github.com/jbittel/httpry"
  url "https://github.com/jbittel/httpry/archive/httpry-0.1.8.tar.gz"
  sha256 "b3bcbec3fc6b72342022e940de184729d9cdecb30aa754a2c994073447468cf0"
  license "GPL-2.0"
  head "https://github.com/jbittel/httpry.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/httpry"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b489c7e582ed226d3c1904e0cc23d2ab373044e1383c58defd6cd75cb1e06ffa"
  end

  uses_from_macos "libpcap"

  def install
    system "make"
    bin.install "httpry"
    man1.install "httpry.1"
    doc.install Dir["doc/*"]
  end

  test do
    system bin/"httpry", "-h"
  end
end
