class Murex < Formula
  desc "Bash-like shell designed for greater command-line productivity and safer scripts"
  homepage "https://murex.rocks"
  url "https://github.com/lmorg/murex/archive/v2.8.2100.tar.gz"
  sha256 "ba3fd505aaa8e8289f1baf0375d319b4f7fa9cda2ba4e6299d63705154f70406"
  license "GPL-2.0-only"
  head "https://github.com/lmorg/murex.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/murex"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e855fab9c1db4e9540be56761c4cd917e890f4869dbea0ee12ab993c8035feb0"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    system "#{bin}/murex", "--run-tests"
    assert_equal "homebrew", shell_output("#{bin}/murex -c 'echo homebrew'").chomp
  end
end
