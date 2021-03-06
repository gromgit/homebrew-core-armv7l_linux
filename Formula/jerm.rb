class Jerm < Formula
  desc "Communication terminal through serial and TCP/IP interfaces"
  homepage "https://web.archive.org/web/20160719014241/bsddiary.net/jerm/"
  url "https://web.archive.org/web/20160719014241/bsddiary.net/jerm/jerm-8096.tar.gz"
  mirror "https://dotsrc.dl.osdn.net/osdn/fablib/62057/jerm-8096.tar.gz"
  version "0.8096"
  sha256 "8a63e34a2c6a95a67110a7a39db401f7af75c5c142d86d3ba300a7b19cbcf0e9"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jerm"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "afcaf03bc9e0163b11e9c68393c342073da5c6fb044c84c7198d78660e2f7475"
  end

  def install
    system "make", "all"
    bin.install %w[jerm tiocdtr]
    man1.install Dir["*.1"]
  end
end
