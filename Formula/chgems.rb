class Chgems < Formula
  desc "Chroot for Ruby gems"
  homepage "https://github.com/postmodern/chgems#readme"
  url "https://github.com/postmodern/chgems/archive/v0.3.2.tar.gz"
  sha256 "515d1bfebb5d5183a41a502884e329fd4c8ddccb14ba8a6548a1f8912013f3dd"
  license "MIT"
  head "https://github.com/postmodern/chgems.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/chgems"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "37e35e913e37a9a68c1b51951ff0ce8adcf7a5422b73e5d1f8e8be46c15ed0fa"
  end

  deprecate! date: "2021-12-09", because: :repo_archived

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    output = shell_output("#{bin}/chgems . gem env")
    assert_match "rubygems.org", output
  end
end
