class Codespell < Formula
  include Language::Python::Virtualenv

  desc "Fix common misspellings in source code and text files"
  homepage "https://github.com/codespell-project/codespell"
  url "https://files.pythonhosted.org/packages/26/37/c524f1750635cb8806240013af1fd4147a60019f9a80e788759e3d2fb644/codespell-2.1.0.tar.gz"
  sha256 "19d3fe5644fef3425777e66f225a8c82d39059dcfe9edb3349a8a2cf48383ee5"
  license "GPL-2.0-only"
  revision 1

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/codespell"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "0c3187a852a2b2bd642ac7dbf82251d0158cb33ea83bf5c78bfe16535af45a23"
  end

  depends_on "python@3.10"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_equal "1: teh\n\tteh ==> the\n", pipe_output("#{bin}/codespell -", "teh", 65)
  end
end
