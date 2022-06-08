class Lux < Formula
  desc "Fast and simple video downloader"
  homepage "https://github.com/iawia002/lux"
  url "https://github.com/iawia002/lux/archive/v0.15.0.tar.gz"
  sha256 "41e45542587caa27bf8180e66c72c6c77e83d00f8dcba2e952c5a9b04d382c6c"
  license "MIT"
  head "https://github.com/iawia002/lux.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/lux"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b04c2223fad6648f918b78d431f0ac1ecd65a20872cd2a35bf7ef061677f6c8d"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    system bin/"lux", "-i", "https://github.githubassets.com/images/modules/site/icons/footer/github-logo.svg"
  end
end
