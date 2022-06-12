class Dsocks < Formula
  desc "SOCKS client wrapper for *BSD/macOS"
  homepage "https://monkey.org/~dugsong/dsocks/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/dsocks/dsocks-1.8.tar.gz"
  sha256 "2b57fb487633f6d8b002f7fe1755480ae864c5e854e88b619329d9f51c980f1d"
  license "BSD-2-Clause"
  head "https://github.com/dugsong/dsocks.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dsocks"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "0d5a118fe76468f978b2a01d5c9ddd5828c8e4eb63540833173ac5b001b68075"
  end

  def install
    system ENV.cc, "-fPIC", "-shared", "-o", shared_library("libdsocks"), "dsocks.c",
                   "atomicio.c", "-lresolv"
    inreplace "dsocks.sh", "/usr/local", HOMEBREW_PREFIX

    lib.install shared_library("libdsocks")
    bin.install "dsocks.sh"
  end
end
