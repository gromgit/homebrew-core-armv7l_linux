# From: Jacques Distler <distler@golem.ph.utexas.edu>
# You can always find the latest version by checking
#    https://golem.ph.utexas.edu/~distler/code/itexToMML/view/head:/itex-src/itex2MML.h
# The corresponding versioned archive is
#    https://golem.ph.utexas.edu/~distler/blog/files/itexToMML-x.x.x.tar.gz

class Itex2mml < Formula
  desc "Text filter to convert itex equations to MathML"
  homepage "https://golem.ph.utexas.edu/~distler/blog/itex2MML.html"
  url "https://golem.ph.utexas.edu/~distler/blog/files/itexToMML-1.6.1.tar.gz"
  sha256 "3ef2572aa3421cf4d12321905c9c3f6b68911c3c9283483b7a554007010be55f"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  livecheck do
    url :homepage
    regex(%r{<b>\s*Current itex2MML Version:\s*</b>\s*(\d+(?:\.\d+)+)[\s(<]}im)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/itex2mml"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d7ef3f638acc7b51dca7696152a1476756bf61986c912d57c3790dbffccba8f3"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  def install
    bin.mkpath
    cd "itex-src" do
      system "make"
      system "make", "install", "prefix=#{prefix}", "BINDIR=#{bin}"
    end
  end

  test do
    input = "$f(x)$"
    output = "<math xmlns='http://www.w3.org/1998/Math/MathML' display='inline'><semantics><mrow>" \
             "<mi>f</mi><mo stretchy=\"false\">(</mo><mi>x</mi><mo stretchy=\"false\">)</mo></mrow>" \
             "<annotation encoding='application/x-tex'>f(x)</annotation></semantics></math>"
    assert_equal output, pipe_output("#{bin}/itex2MML", input)
  end
end
