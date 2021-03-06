class Serd < Formula
  desc "C library for RDF syntax"
  homepage "https://drobilla.net/software/serd.html"
  url "https://download.drobilla.net/serd-0.30.12.tar.bz2"
  sha256 "9f9dab4125d88256c1f694b6638cbdbf84c15ce31003cd83cb32fb2192d3e866"
  license "ISC"

  livecheck do
    url "https://download.drobilla.net/"
    regex(/href=.*?serd[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/serd"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "43acd40a2211ae6a1c7e0376458c97ba8c7bd34b1943c8c9944b622bb13064d1"
  end

  depends_on "pkg-config" => :build
  depends_on "python@3.10" => :build

  def install
    system "python3", "./waf", "configure", "--prefix=#{prefix}"
    system "python3", "./waf"
    system "python3", "./waf", "install"
  end

  test do
    rdf_syntax_ns = "http://www.w3.org/1999/02/22-rdf-syntax-ns"
    re = %r{(<#{Regexp.quote(rdf_syntax_ns)}#.*>\s+)?<http://example.org/List>\s+\.}
    assert_match re, pipe_output("serdi -", "() a <http://example.org/List> .")
  end
end
