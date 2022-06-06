class Bork < Formula
  desc "Bash-Operated Reconciling Kludge"
  homepage "https://bork.sh/"
  url "https://github.com/borksh/bork/archive/v0.13.0.tar.gz"
  sha256 "5eaca1ebd984121df008b93c43ac259a455db7ccf13da1b1465d704e1faab563"
  license "Apache-2.0"
  head "https://github.com/borksh/bork.git", branch: "main"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bork"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "9fd828ce87277cc3e9a312b56869e87156fa56ec1d6ec8649ad76192f447f25a"
  end

  def install
    files = %w[types/shells.sh types/pipsi.sh types/cask.sh test/type-pipsi.bats test/type-cask.bats]
    inreplace files, "/usr/local/", HOMEBREW_PREFIX

    man1.install "docs/bork.1"
    prefix.install %w[bin lib test types]
  end

  test do
    expected_output = "checking: directory #{testpath}/foo\r" \
                      "missing: directory #{testpath}/foo           \n" \
                      "verifying : directory #{testpath}/foo\n" \
                      "* success\n"
    assert_match expected_output, shell_output("#{bin}/bork do ok directory #{testpath}/foo", 1)
  end
end
