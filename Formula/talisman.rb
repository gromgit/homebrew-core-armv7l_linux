class Talisman < Formula
  desc "Tool to detect and prevent secrets from getting checked in"
  homepage "https://thoughtworks.github.io/talisman/"
  url "https://github.com/thoughtworks/talisman/archive/v1.27.0.tar.gz"
  sha256 "2eb244553dfbb5f97fcab1774f2d1295cae9e7d4ee8f9d3b351ea5aef1387a78"
  license "MIT"
  version_scheme 1
  head "https://github.com/thoughtworks/talisman.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/talisman"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "558c3a11932eacbcc99c19f57f86876bb216a40da8b163d57a444084d477e95b"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.Version=#{version}"), "./cmd"
  end

  test do
    system "git", "init", "."
    assert_match "talisman scan report", shell_output(bin/"talisman --scan")
  end
end
