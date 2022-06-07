class Ccat < Formula
  desc "Like cat but displays content with syntax highlighting"
  homepage "https://github.com/owenthereal/ccat"
  url "https://github.com/owenthereal/ccat/archive/v1.1.0.tar.gz"
  sha256 "b02d2c8d573f5d73595657c7854c9019d3bd2d9e6361b66ce811937ffd2bfbe1"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ccat"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d9f3631090476748906a222fe61fb05c4fb92681d80fb86e11d9247e3ba8af99"
  end

  depends_on "go" => :build

  conflicts_with "ccrypt", because: "both install `ccat` binaries"

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    system "./script/build"
    bin.install "ccat"
  end

  test do
    (testpath/"test.txt").write <<~EOS
      I am a colourful cat
    EOS

    assert_match(/I am a colourful cat/, shell_output("#{bin}/ccat test.txt"))
  end
end
