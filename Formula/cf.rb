class Cf < Formula
  desc "Filter to replace numeric timestamps with a formatted date time"
  homepage "https://ee.lbl.gov/"
  url "https://ee.lbl.gov/downloads/cf/cf-1.2.5.tar.gz"
  sha256 "ef65e9eb57c56456dfd897fec12da8617c775e986c23c0b9cbfab173b34e5509"

  livecheck do
    url "https://ee.lbl.gov/downloads/cf/"
    regex(/href=.*?cf[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cf"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d2b83a219386bea447252135287ee2d6ed3863c5b498486c6d71d624d0492381"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    bin.mkpath
    man1.mkpath
    system "make", "install"
    system "make", "install-man"
  end

  test do
    assert_match "Jan 20 00:35:44", pipe_output("#{bin}/cf -u", "1074558944")
  end
end
