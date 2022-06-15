class Pdf2json < Formula
  desc "PDF to JSON and XML converter"
  homepage "https://github.com/flexpaper/pdf2json"
  url "https://github.com/flexpaper/pdf2json/archive/0.71.tar.gz"
  sha256 "54878473a2afb568caf2da11d6804cabe0abe505da77584a3f8f52bcd37d9c55"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pdf2json"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "64869022d1650838fad1ab0626f4019493e930d4d27811d42540ce88074f9300"
  end

  def install
    system "./configure"
    system "make", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}"
    bin.install "src/pdf2json"
  end

  test do
    system bin/"pdf2json", test_fixtures("test.pdf"), "test.json"
    assert_predicate testpath/"test.json", :exist?
  end
end
