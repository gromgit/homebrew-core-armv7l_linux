class Cdpr < Formula
  desc "Cisco Discovery Protocol Reporter"
  homepage "http://www.monkeymental.com/"
  url "https://downloads.sourceforge.net/project/cdpr/cdpr/2.4/cdpr-2.4.tgz"
  sha256 "32d3b58d8be7e2f78834469bd5f48546450ccc2a86d513177311cce994dfbec5"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cdpr"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "5e5940f3878328230e71bdda0731a5fd0c36bd0a06a8998f4415542e9e8712ce"
  end

  uses_from_macos "libpcap"

  def install
    # Makefile hardcodes gcc and other atrocities
    system ENV.cc, "cdpr.c", "cdprs.c", "conffile.c", "-lpcap", "-o", "cdpr"
    bin.install "cdpr"
  end

  def caveats
    "run cdpr sudo'd in order to avoid the error: 'No interfaces found! Make sure pcap is installed.'"
  end

  test do
    system "#{bin}/cdpr", "-h"
  end
end
