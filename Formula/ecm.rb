class Ecm < Formula
  desc "Prepare CD image files so they compress better"
  homepage "https://web.archive.org/web/20140227165748/www.neillcorlett.com/ecm/"
  url "https://web.archive.org/web/20091021035854/www.neillcorlett.com/downloads/ecm100.zip"
  version "1.0"
  sha256 "1d0d19666f46d9a2fc7e534f52475e80a274e93bdd3c010a75fe833f8188b425"

  # The first-party web page was been missing since 2014, so we can't check for
  # new versions and the developer doesn't seem to be actively working on this.
  livecheck do
    skip "No available sources to check for versions"
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ecm"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1adc52b60326706a11387f679e01f8d52e61261e85c1e05f900b2c1bc1e75428"
  end

  def install
    system ENV.cc, "-o", "ecm", "ecm.c"
    system ENV.cc, "-o", "unecm", "unecm.c"
    bin.install "ecm", "unecm"
  end
end
