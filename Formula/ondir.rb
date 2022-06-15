class Ondir < Formula
  desc "Automatically execute scripts as you traverse directories"
  homepage "https://swapoff.org/ondir.html"
  url "https://swapoff.org/files/ondir/ondir-0.2.3.tar.gz"
  sha256 "504a677e5b7c47c907f478d00f52c8ea629f2bf0d9134ac2a3bf0bbe64157ba3"
  license "GPL-2.0"
  head "https://github.com/alecthomas/ondir.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ondir"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f68280dbdaf7b45aecda3534925734c8b358f28ea429d180d984640928af88d4"
  end

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end
end
