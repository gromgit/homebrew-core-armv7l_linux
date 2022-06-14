class Gif2png < Formula
  desc "Convert GIFs to PNGs"
  homepage "http://www.catb.org/~esr/gif2png/"
  url "http://www.catb.org/~esr/gif2png/gif2png-2.5.13.tar.gz"
  sha256 "997275b20338e6cfe3bd4adb084f82627c34c856bc1d67c915c397cf55146924"

  livecheck do
    url :homepage
    regex(/href=.*?gif2png[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gif2png"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "721058d83f2e2ec0fc371fae799dffe853e68414ea907c7ba278ba2ab294f37d"
  end

  depends_on "libpng"

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    pipe_output "#{bin}/gif2png -O", File.read(test_fixtures("test.gif"))
  end
end
