class BundlerCompletion < Formula
  desc "Bash completion for Bundler"
  homepage "https://github.com/mernen/completion-ruby"
  url "https://github.com/mernen/completion-ruby.git",
      revision: "f3e4345042b0cc48317e45b673dfd3d23904b9a7"
  version "2"
  license "MIT"
  head "https://github.com/mernen/completion-ruby.git", branch: "main"

  livecheck do
    formula "ruby-completion"
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bundler-completion"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "73a42f2dac69b1b2aaa25305fb75a473ad79f9074ead2f5821b622f6b0a2ddd7"
  end

  def install
    bash_completion.install "completion-bundle" => "bundler"
  end

  test do
    assert_match "-F __bundle",
      shell_output("bash -c 'source #{bash_completion}/bundler && complete -p bundle'")
  end
end
