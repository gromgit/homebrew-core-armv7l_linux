class Codemod < Formula
  include Language::Python::Virtualenv

  desc "Large-scale codebase refactors assistant tool"
  homepage "https://github.com/facebook/codemod"
  url "https://files.pythonhosted.org/packages/9b/e3/cb31bfcf14f976060ea7b7f34135ebc796cde65eba923f6a0c4b71f15cc2/codemod-1.0.0.tar.gz"
  sha256 "06e8c75f2b45210dd8270e30a6a88ae464b39abd6d0cab58a3d7bfd1c094e588"
  license "Apache-2.0"
  revision 5
  version_scheme 1
  head "https://github.com/facebook/codemod.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/codemod"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1df1e89463e448de3d9bc5b770e8983baec14b02621b6a59b6dfebb44ffc8d37"
  end

  deprecate! date: "2021-07-13", because: :repo_archived

  depends_on "python@3.10"

  def install
    virtualenv_install_with_resources
  end

  test do
    # work around some codemod terminal bugs
    ENV["TERM"] = "xterm"
    ENV["LINES"] = "25"
    ENV["COLUMNS"] = "80"
    (testpath/"file1").write <<~EOS
      foo
      bar
      potato
      baz
    EOS
    (testpath/"file2").write <<~EOS
      eeny potato meeny miny moe
    EOS
    system bin/"codemod", "--include-extensionless", "--accept-all", "potato", "pineapple"
    assert_equal %w[foo bar pineapple baz], File.read("file1").lines.map(&:strip)
    assert_equal ["eeny pineapple meeny miny moe"], File.read("file2").lines.map(&:strip)
  end
end
