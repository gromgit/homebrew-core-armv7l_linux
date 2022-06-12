class Dterm < Formula
  desc "Terminal emulator for use with xterm and friends"
  homepage "http://www.knossos.net.nz/resources/free-software/dterm/"
  url "http://www.knossos.net.nz/downloads/dterm-0.5.tgz"
  sha256 "94533be79f1eec965e59886d5f00a35cb675c5db1d89419f253bb72f140abddb"
  license "GPL-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?dterm[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dterm"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "dc8fe13736df8d864e6179656ffc61984cc22d8c8eb531b13eacca4f3b7f9e75"
  end

  on_linux do
    depends_on "readline"
  end

  def install
    bin.mkpath
    system "make"
    system "make", "install", "BIN=#{bin}/"
  end

  test do
    system "#{bin}/dterm", "help"
  end
end
