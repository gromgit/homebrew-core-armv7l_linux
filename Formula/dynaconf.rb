class Dynaconf < Formula
  include Language::Python::Virtualenv

  desc "Configuration Management for Python"
  homepage "https://www.dynaconf.com/"
  url "https://files.pythonhosted.org/packages/2c/45/76c978c725b020be65a95b8b427e3550c76478a90e5396a33b0b204cae45/dynaconf-3.1.8.tar.gz"
  sha256 "d141a6664fca3648d2d8e84440966af9f58c4f4201ca78353a3f595a67c19ab4"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dynaconf"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b96c57c2b6dce4b1b789338e794a89156ed516a826375f1a43402b57f3b4016d"
  end

  depends_on "python@3.10"

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"dynaconf", "init"
    assert_predicate testpath/"settings.toml", :exist?
    assert_match "from dynaconf import Dynaconf", (testpath/"config.py").read
  end
end
