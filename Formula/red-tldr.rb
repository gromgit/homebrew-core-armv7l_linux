class RedTldr < Formula
  desc "Used to help red team staff quickly find the commands and key points"
  homepage "https://payloads.online/red-tldr/"
  url "https://github.com/Rvn0xsy/red-tldr/archive/v0.4.3.tar.gz"
  sha256 "3f32a438226287d80ae86509964d7767c2002952c95da03501beb882cae22d2d"
  license "MIT"
  head "https://github.com/Rvn0xsy/red-tldr.git", branch: "main"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/red-tldr"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f31eb3a45b23773f0a6ddb2a8451117482f135a464ea3d57dca2fffdaf032ff7"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "privilege", shell_output("#{bin}/red-tldr mimikatz")
  end
end
