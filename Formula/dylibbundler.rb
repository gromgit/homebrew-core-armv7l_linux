class Dylibbundler < Formula
  desc "Utility to bundle libraries into executables for macOS"
  homepage "https://github.com/auriamg/macdylibbundler"
  url "https://github.com/auriamg/macdylibbundler/archive/1.0.4.tar.gz"
  sha256 "839c6a30be2c974bba70ab80faf8167713955bb010427662b14d4af7df8d5f19"
  license "MIT"
  head "https://github.com/auriamg/macdylibbundler.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dylibbundler"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f0f5b47f1ebfa789ebfb909701ac11e058196ef9eb30f31e23f3227173881cf6"
  end

  def install
    system "make"
    bin.install "dylibbundler"
  end

  test do
    system "#{bin}/dylibbundler", "-h"
  end
end
