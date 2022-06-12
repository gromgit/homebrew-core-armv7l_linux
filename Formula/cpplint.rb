class Cpplint < Formula
  include Language::Python::Virtualenv

  desc "Static code checker for C++"
  homepage "https://pypi.org/project/cpplint/"
  url "https://files.pythonhosted.org/packages/c5/0f/4f2de12a37b1cbfefabff29ef8d529336c2ceec3226e270b369e8e52c735/cpplint-1.6.0.tar.gz"
  sha256 "8af99f95ed1af2d18e60467cdc13ee0441c2a14d693b7d2dbb71ad427074e491"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cpplint"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "cec01f60ab0ea49a23dd3c6391bab54bb9f89d96aef2eecc15fc44ad5213c41b"
  end

  depends_on "python@3.10"

  def install
    virtualenv_install_with_resources

    # install test data
    pkgshare.install "samples"
  end

  test do
    output = shell_output("#{bin}/cpplint --version")
    assert_match "cpplint #{version}", output.strip

    output = shell_output("#{bin}/cpplint #{pkgshare}/samples/v8-sample/src/interface-descriptors.h", 1)
    assert_match "Total errors found: 2", output
  end
end
