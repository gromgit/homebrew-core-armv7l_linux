class Jvgrep < Formula
  desc "Grep for Japanese users of Vim"
  homepage "https://github.com/mattn/jvgrep"
  url "https://github.com/mattn/jvgrep/archive/v5.8.9.tar.gz"
  sha256 "37e1b9aa4571f98a102b4f7322d7f581c608c0fcd50542dfaa7af742184fb1dc"
  license "MIT"
  head "https://github.com/mattn/jvgrep.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jvgrep"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "878b823459d5377e1cf8d2e0e4e47d129a5382fa660e323c6669eed54d61fd53"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    (testpath/"Hello.txt").write("Hello World!")
    system bin/"jvgrep", "Hello World!", testpath
  end
end
