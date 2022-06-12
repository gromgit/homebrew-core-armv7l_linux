class Darkhttpd < Formula
  desc "Small static webserver without CGI"
  homepage "https://unix4lyfe.org/darkhttpd/"
  url "https://github.com/emikulic/darkhttpd/archive/v1.13.tar.gz"
  sha256 "1d88c395ac79ca9365aa5af71afe4ad136a4ed45099ca398168d4a2014dc0fc2"
  license "ISC"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/darkhttpd"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b1966b9911751190c15d325044bc350c985305bd95afd5d2f5e06f89f2d555a2"
  end

  def install
    system "make"
    bin.install "darkhttpd"
  end

  test do
    system "#{bin}/darkhttpd", "--help"
  end
end
