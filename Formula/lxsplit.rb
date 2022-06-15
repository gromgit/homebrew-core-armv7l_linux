class Lxsplit < Formula
  desc "Tool for splitting or joining files"
  homepage "https://lxsplit.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/lxsplit/lxsplit/0.2.4/lxsplit-0.2.4.tar.gz"
  sha256 "858fa939803b2eba97ccc5ec57011c4f4b613ff299abbdc51e2f921016845056"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/lxsplit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3a745c0911f1c1f98589d706b73b4d8924bcfebd7bb2d5d7d06fb3839f9f8b3e"
  end

  def install
    bin.mkpath
    inreplace "Makefile", "/usr/local/bin", bin
    system "make"
    system "make", "install"
  end
end
