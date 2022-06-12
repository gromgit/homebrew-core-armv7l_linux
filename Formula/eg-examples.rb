class EgExamples < Formula
  include Language::Python::Virtualenv

  desc "Useful examples at the command-line"
  homepage "https://github.com/srsudar/eg"
  url "https://files.pythonhosted.org/packages/8b/b7/88e0333b9a3633ec686246b5f1c1ee4cad27246ab5206b511fd5127e506f/eg-1.2.1.tar.gz"
  sha256 "e3608ec0b05fffa0faec0b01baeb85c128e0b3c836477063ee507077a2b2dc0c"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/eg-examples"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ab6c136dcb37a04a7874f62686a732c85b14f4cd543516328f2c7d393d2a737e"
  end

  depends_on "python@3.10"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_equal version, shell_output("#{bin}/eg --version")

    output = shell_output("#{bin}/eg whatis")
    assert_match "search for entries containing a command", output
  end
end
