class LizardAnalyzer < Formula
  include Language::Python::Virtualenv

  desc "Extensible Cyclomatic Complexity Analyzer"
  homepage "http://www.lizard.ws"
  url "https://files.pythonhosted.org/packages/ef/70/bbb7c6b5d1b29acca0cd13582a7303fc528e6dbf40d0026861f9aa7f3ff0/lizard-1.17.10.tar.gz"
  sha256 "62d78acd64724be28b5f4aa27a630dfa4b4afbd1596d1f25d5ad1c1a3a075adc"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/lizard-analyzer"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "279fba6afcd4c0c9425254f7900deca80d14b932454e872e739b8bfcbfc0fc97"
  end

  depends_on "python@3.10"

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"test.swift").write <<~'EOS'
      let base = 2
      let exponent_inner = 3
      let exponent_outer = 4
      var answer = 1

      for _ in 1...exponent_outer {
        for _ in 1...exponent_inner {
          answer *= base
        }
      }
    EOS
    assert_match "1 file analyzed.\n", shell_output("#{bin}/lizard -l swift #{testpath}/test.swift")
  end
end
