class Apng2gif < Formula
  desc "Convert APNG animations into animated GIF format"
  homepage "https://apng2gif.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/apng2gif/1.8/apng2gif-1.8-src.zip"
  sha256 "9a07e386017dc696573cd7bc7b46b2575c06da0bc68c3c4f1c24a4b39cdedd4d"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/apng2gif"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c9283ec4d93389aebc8ca643ca54f3438f5d80a69979c54e1367c614916e5493"
  end

  depends_on "libpng"

  def install
    system "make"
    bin.install "apng2gif"
  end

  test do
    cp test_fixtures("test.png"), testpath/"test.png"
    system bin/"apng2gif", testpath/"test.png"
    assert_predicate testpath/"test.gif", :exist?, "Failed to create test.gif"
  end
end
