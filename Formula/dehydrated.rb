class Dehydrated < Formula
  desc "LetsEncrypt/acme client implemented as a shell-script"
  homepage "https://dehydrated.io"
  url "https://github.com/dehydrated-io/dehydrated/archive/v0.7.0.tar.gz"
  sha256 "1c5f12c2e57e64b1762803f82f0f7e767a72e65a6ce68e4d1ec197e61b9dc4f9"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dehydrated"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e4f179282544d70d072f6ebea22527d7dfbb8a0d810d5965fc7266918fef4f6d"
  end

  def install
    bin.install "dehydrated"
    man1.install "docs/man/dehydrated.1"
  end

  test do
    system bin/"dehydrated", "--help"
  end
end
