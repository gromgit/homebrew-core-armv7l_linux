class SpaceinvadersGo < Formula
  desc "Space Invaders in your terminal written in Go"
  homepage "https://github.com/asib/spaceinvaders"
  url "https://github.com/asib/spaceinvaders/archive/v1.2.1.tar.gz"
  sha256 "3fef982b94784d34ac2ae68c1d5dec12e260974907bce83528fe3c4132bed377"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/spaceinvaders-go"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "edf06a5d07ce6f95695ad3bb854d1c90fff37c40efc1db2556d30481a052c07f"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w", "-o", bin/"spaceinvaders"
  end

  test do
    IO.popen("#{bin}/spaceinvaders", "r+") do |pipe|
      pipe.puts "q"
      pipe.close_write
      pipe.close
    end
  end
end
