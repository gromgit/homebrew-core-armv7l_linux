class Guetzli < Formula
  desc "Perceptual JPEG encoder"
  homepage "https://github.com/google/guetzli"
  url "https://github.com/google/guetzli/archive/v1.0.1.tar.gz"
  sha256 "e52eb417a5c0fb5a3b08a858c8d10fa797627ada5373e203c196162d6a313697"
  license "Apache-2.0"
  head "https://github.com/google/guetzli.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/guetzli"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c685fcd8dc4e973152fc983b188e30b3e0e074d692756c2d79f9542f73c71694"
  end

  depends_on "pkg-config" => :build
  depends_on "libpng"

  resource "test_image" do
    url "https://github.com/google/guetzli/releases/download/v1.0/bees.png"
    sha256 "2c1784bf4efb90c57f00a3ab4898ac8ec4784c60d7a0f70d2ba2c00af910520b"
  end

  def install
    system "make"
    bin.install "bin/Release/guetzli"
  end

  test do
    resource("test_image").stage { system "#{bin}/guetzli", "bees.png", "bees.jpg" }
  end
end
