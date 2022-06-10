class Docutils < Formula
  include Language::Python::Virtualenv

  desc "Text processing system for reStructuredText"
  homepage "https://docutils.sourceforge.io"
  url "https://downloads.sourceforge.net/project/docutils/docutils/0.18.1/docutils-0.18.1.tar.gz"
  sha256 "679987caf361a7539d76e584cbeddc311e3aee937877c87346f31debc63e9d06"
  license all_of: [:public_domain, "BSD-2-Clause", "GPL-3.0-or-later", "Python-2.0"]

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/docutils"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "47fb15b4bb9a6bf46d4a2d6f488aa614c00b2780b3f32b7e89bcbfd8a5af1b66"
  end

  depends_on "python@3.10"

  def install
    virtualenv_install_with_resources

    Dir.glob("#{libexec}/bin/*.py") do |f|
      bin.install_symlink f => File.basename(f, ".py")
    end
  end

  test do
    system "#{bin}/rst2man.py", "#{prefix}/HISTORY.txt"
  end
end
