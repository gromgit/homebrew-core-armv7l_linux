class Jsonpp < Formula
  desc "Command-line JSON pretty-printer"
  homepage "https://jmhodges.github.io/jsonpp/"
  url "https://github.com/jmhodges/jsonpp/archive/1.3.0.tar.gz"
  sha256 "dde8ea9b270a79cd2b2f40824f89abc5270bd360122d87ab04b4361c0015d941"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jsonpp"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ca530b0e4d16883934c421338f3bd0b4a7991ff12bd251c3cde8271db2b4d237"
  end

  depends_on "go" => :build

  def install
    ENV["GO111MODULE"] = "auto"
    system "go", "build", "-o", bin/"jsonpp"
  end

  test do
    expected = <<~EOS.chomp
      {
        "foo": "bar",
        "baz": "qux"
      }
    EOS
    assert_equal expected, pipe_output(bin/"jsonpp", '{"foo":"bar","baz":"qux"}')
  end
end
