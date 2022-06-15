class Montage < Formula
  desc "Toolkit for assembling FITS images into custom mosaics"
  homepage "http://montage.ipac.caltech.edu"
  url "http://montage.ipac.caltech.edu/download/Montage_v4.0.tar.gz"
  sha256 "de143e4d4b65086f04bb75cf482dfa824965a5a402f3431f9bceb395033df5fe"
  license "BSD-3-Clause"
  head "https://github.com/Caltech-IPAC/Montage.git", branch: "main"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/montage"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7157501778a490091701e34b5fbc66b7d66288118782c166fa40d1c990335297"
  end

  conflicts_with "wdiff", because: "both install an `mdiff` executable"

  def install
    system "make"
    bin.install Dir["bin/m*"]
  end

  def caveats
    <<~EOS
      Montage is under the Caltech/JPL non-exclusive, non-commercial software
      licence agreement available at:
        http://montage.ipac.caltech.edu/docs/download.html
    EOS
  end

  test do
    system bin/"mHdr", "m31", "1", "template.hdr"
  end
end
