class Devdash < Formula
  desc "Highly Configurable Terminal Dashboard for Developers"
  homepage "https://thedevdash.com"
  url "https://github.com/Phantas0s/devdash/archive/v0.5.0.tar.gz"
  sha256 "633a0a599a230a93b7c4eeacdf79a91a2bb672058ef3d5aacce5121167df8d28"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/devdash"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ef560a22a57995339a7d4d522c240b383e6cfc2d78c100d141e01a9bf1c5672e"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    system bin/"devdash", "-h"
  end
end
