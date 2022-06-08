class Httpdiff < Formula
  desc "Compare two HTTP(S) responses"
  homepage "https://github.com/jgrahamc/httpdiff"
  url "https://github.com/jgrahamc/httpdiff/archive/v1.0.0.tar.gz"
  sha256 "b2d3ed4c8a31c0b060c61bd504cff3b67cd23f0da8bde00acd1bfba018830f7f"
  license "GPL-2.0"
  head "https://github.com/jgrahamc/httpdiff.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/httpdiff"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e22f590f3dd68a3abbae68c75095081723480946e31a964ae8023f786e99d980"
  end

  depends_on "go" => :build

  def install
    ENV["GO111MODULE"] = "auto"
    system "go", "build", "-o", bin/"httpdiff"
  end

  test do
    system bin/"httpdiff", "https://brew.sh/", "https://brew.sh/"
  end
end
