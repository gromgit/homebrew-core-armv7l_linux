class Aha < Formula
  desc "ANSI HTML adapter"
  homepage "https://github.com/theZiz/aha"
  url "https://github.com/theZiz/aha/archive/0.5.1.tar.gz"
  sha256 "6aea13487f6b5c3e453a447a67345f8095282f5acd97344466816b05ebd0b3b1"
  license "LGPL-2.1"
  head "https://github.com/theZiz/aha.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/aha"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "32ce8a674ecb44ff9a4c7ee09a9a044f68d52ab6bc4a34021297fb91bf2ba189"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    out = pipe_output(bin/"aha", "[35mrain[34mpill[00m")
    assert_match(/color:purple;">rain.*color:blue;">pill/, out)
  end
end
