class Slacknimate < Formula
  desc "Text animation for Slack messages"
  homepage "https://github.com/mroth/slacknimate"
  url "https://github.com/mroth/slacknimate/archive/v1.1.0.tar.gz"
  sha256 "71c7a65192c8bbb790201787fabbb757de87f8412e0d41fe386c6b4343cb845c"
  license "MPL-2.0"
  head "https://github.com/mroth/slacknimate.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/slacknimate"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "944a1bee4922afdfb2ac4c1e09d5a342996eeb712d2d8f35f00f5d5ec907fa25"
  end

  depends_on "go" => :build

  def install
    system "go", "build",
      "-ldflags", "-s -w -X main.version=#{version}", *std_go_args, "./cmd/slacknimate"
  end

  test do
    system "#{bin}/slacknimate", "--version"
    system "#{bin}/slacknimate", "--help"
  end
end
