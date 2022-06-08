class Scmpuff < Formula
  desc "Adds numbered shortcuts for common git commands"
  homepage "https://mroth.github.io/scmpuff/"
  url "https://github.com/mroth/scmpuff/archive/v0.5.0.tar.gz"
  sha256 "e07634c7207dc51479d39895e546dd0107a50566faf5c2067f61a3b92c824fbf"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/scmpuff"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7f53efa4f3e913eaafc6cbb6b27cc1718a78be55cea76be7e48beea889ee195c"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -v -X main.VERSION=#{version}"
  end

  test do
    ENV["e1"] = "abc"
    assert_equal "abc", shell_output("#{bin}/scmpuff expand 1").strip
  end
end
