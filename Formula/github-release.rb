class GithubRelease < Formula
  desc "Create and edit releases on Github (and upload artifacts)"
  homepage "https://github.com/github-release/github-release"
  url "https://github.com/github-release/github-release/archive/v0.10.0.tar.gz"
  sha256 "79bfaa465f549a08c781f134b1533f05b02f433e7672fbaad4e1764e4a33f18a"
  license "MIT"
  head "https://github.com/github-release/github-release.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/github-release"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "0bf464bac75ed6a111a2c209f13ec4b818f866274d6e0f36f2c3fa455fa9922b"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    system "make"
    bin.install "github-release"
  end

  test do
    system "#{bin}/github-release", "info", "--user", "github-release",
                                            "--repo", "github-release",
                                            "--tag", "v#{version}"
  end
end
