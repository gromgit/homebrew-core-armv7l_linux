class Ekhtml < Formula
  desc "Forgiving SAX-style HTML parser"
  homepage "https://ekhtml.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/ekhtml/ekhtml/0.3.2/ekhtml-0.3.2.tar.gz"
  sha256 "1ed1f0166cd56552253cd67abcfa51728ff6b88f39bab742dbf894b2974dc8d6"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ekhtml"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c36f31ccc8f3378f2a85a4e550f302ab999e905d3d6780c98b0de44007165350"
  end

  def install
    ENV.deparallelize
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
