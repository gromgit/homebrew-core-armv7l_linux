class Cksfv < Formula
  desc "File verification utility"
  homepage "https://zakalwe.fi/~shd/foss/cksfv/"
  url "https://zakalwe.fi/~shd/foss/cksfv/files/cksfv-1.3.15.tar.bz2"
  sha256 "a173be5b6519e19169b6bb0b8a8530f04303fe3b17706927b9bd58461256064c"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://zakalwe.fi/~shd/foss/cksfv/files/"
    regex(/href=.*?cksfv[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cksfv"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "cdb5f997ce31a4998fd68f5164c8b0fd7ab8a61622d1e7be16909eb2a6986ecb"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    path = testpath/"foo"
    path.write "abcd"

    assert_match "#{path} ED82CD11", shell_output("#{bin}/cksfv #{path}")
  end
end
