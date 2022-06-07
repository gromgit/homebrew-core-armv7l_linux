class Gau < Formula
  desc "Open Threat Exchange, Wayback Machine, and Common Crawl URL fetcher"
  homepage "https://github.com/lc/gau"
  url "https://github.com/lc/gau/archive/v2.1.1.tar.gz"
  sha256 "17bd5b8e3a6a554d82ab5de66bc1f34ce2810a3ba6b8e1456432faff9b191c8f"
  license "MIT"
  head "https://github.com/lc/gau.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gau"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "29d1652f21d7b54b278a0fcc70649f58804740e494aafd6303ffd90daba19342"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/gau"
  end

  test do
    output = shell_output("#{bin}/gau --providers wayback brew.sh")
    assert_match %r{https?://brew\.sh(/|:)?.*}, output
  end
end
