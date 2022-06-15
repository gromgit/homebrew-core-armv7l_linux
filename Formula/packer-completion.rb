class PackerCompletion < Formula
  desc "Bash completion for Packer"
  homepage "https://github.com/mrolli/packer-bash-completion"
  url "https://github.com/mrolli/packer-bash-completion/archive/1.4.3.tar.gz"
  sha256 "af7b3b49b29ffdb05b519dad2d83066f3d166dd8e29abd406ca0f3d480901df4"
  license "MIT"
  head "https://github.com/mrolli/packer-bash-completion.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/packer-completion"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7e01e8935c941c7a9321b0cacfb9146a62bdf91bd5eae4b0e6d76d53c4cfbb5a"
  end

  def install
    bash_completion.install "packer"
  end

  test do
    assert_match "-F _packer_completion",
      shell_output("bash -c 'source #{bash_completion}/packer && complete -p packer'")
  end
end
