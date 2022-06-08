class Muffet < Formula
  desc "Fast website link checker in Go"
  homepage "https://github.com/raviqqe/muffet"
  url "https://github.com/raviqqe/muffet/archive/v2.5.0.tar.gz"
  sha256 "53a0f673181be525ad0c937c0c93d57343dc303886a9b60332730ea17258b52f"
  license "MIT"
  head "https://github.com/raviqqe/muffet.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/muffet"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f8c79fa0072225679c7152652a31d75c1e0852bb7bd821fed1c73fcfe1c91e0d"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match(/failed to fetch root page: lookup does\.not\.exist.*: no such host/,
                 shell_output("#{bin}/muffet https://does.not.exist 2>&1", 1))

    assert_match "https://httpbin.org/",
                 shell_output("#{bin}/muffet https://httpbin.org 2>&1", 1)
  end
end
