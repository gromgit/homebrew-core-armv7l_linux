class Gibo < Formula
  desc "Access GitHub's .gitignore boilerplates"
  homepage "https://github.com/simonwhitaker/gibo"
  url "https://github.com/simonwhitaker/gibo/archive/2.2.7.tar.gz"
  sha256 "9f44af2d1b1f3c5582620b7b5202ee2eb897a19bffc6e0d7ce95c6f0da2688bb"
  license "Unlicense"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gibo"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "2c14c60bc5f047063f1f65d49b677a885ba1176503902c7619da7985354c9859"
  end

  def install
    bin.install "gibo"
    bash_completion.install "shell-completions/gibo-completion.bash"
    zsh_completion.install "shell-completions/gibo-completion.zsh" => "_gibo"
    fish_completion.install "shell-completions/gibo.fish"
  end

  test do
    system "#{bin}/gibo", "update"
    assert_includes shell_output("#{bin}/gibo dump Python"), "Python.gitignore"
  end
end
