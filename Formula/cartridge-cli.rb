class CartridgeCli < Formula
  desc "Tarantool Cartridge command-line utility"
  homepage "https://tarantool.org/"
  url "https://github.com/tarantool/cartridge-cli.git",
      tag:      "2.12.2",
      revision: "53e6a5be9a611323401a3d98d2dd380da4f672f9"
  license "BSD-2-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cartridge-cli"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "2aca35e3a48f70d00deb724896c684dc2871d92ec45cab0fbeb0abd0ce07ce18"
  end

  depends_on "go" => :build
  depends_on "mage" => :build

  def install
    system "mage", "build"
    bin.install "cartridge"
    system bin/"cartridge", "gen", "completion"

    bash_completion.install "completion/bash/cartridge"
    zsh_completion.install "completion/zsh/_cartridge"
  end

  test do
    project_path = Pathname("test-project")
    project_path.rmtree if project_path.exist?
    system bin/"cartridge", "create", "--name", project_path
    assert_predicate project_path, :exist?
    assert_predicate project_path.join("init.lua"), :exist?
  end
end
