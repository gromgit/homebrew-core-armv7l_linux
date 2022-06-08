class Micro < Formula
  desc "Modern and intuitive terminal-based text editor"
  homepage "https://github.com/zyedidia/micro"
  url "https://github.com/zyedidia/micro.git",
      tag:      "v2.0.10",
      revision: "b97638566ea8431712f0faafe23661da2db0e8ec"
  license "MIT"
  head "https://github.com/zyedidia/micro.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/micro"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "eab63e6f550632cd493edbba9270905f75aa671eaadec67211239d44a4b141dc"
  end

  depends_on "go" => :build

  def install
    system "make", "build-tags"
    bin.install "micro"
    man1.install "assets/packaging/micro.1"
    prefix.install_metafiles
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/micro -version")
  end
end
