class Pget < Formula
  desc "File download client"
  homepage "https://github.com/Code-Hex/pget"
  url "https://github.com/Code-Hex/pget/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "34d674dc48144c84de72d525e67d96500243cc1d1c4c0433794495c0846c193f"
  license "MIT"
  head "https://github.com/Code-Hex/pget.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pget"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "83de5ebf5883e604bf5969399a282b8c9015c0de923ee48e54d427aa505c8276"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pget"
  end

  test do
    file = "https://raw.githubusercontent.com/Homebrew/homebrew-core/master/README.md"
    system bin/"pget", "-p", "4", file
    assert_predicate testpath/"README.md", :exist?

    assert_match version.to_s, shell_output("#{bin}/pget --help", 1)
  end
end
