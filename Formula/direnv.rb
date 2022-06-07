class Direnv < Formula
  desc "Load/unload environment variables based on $PWD"
  homepage "https://direnv.net/"
  url "https://github.com/direnv/direnv/archive/v2.31.0.tar.gz"
  sha256 "f82694202f584d281a166bd5b7e877565f96a94807af96325c8f43643d76cb44"
  license "MIT"
  head "https://github.com/direnv/direnv.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/direnv"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b7e5dcf74f11539d0d88f6c866716037653dc68997fc8faa01aabc097f09e0c8"
  end

  depends_on "go" => :build

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"direnv", "status"
  end
end
