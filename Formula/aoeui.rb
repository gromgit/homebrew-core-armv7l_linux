class Aoeui < Formula
  desc "Lightweight text editor optimized for Dvorak and QWERTY keyboards"
  homepage "https://code.google.com/archive/p/aoeui/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/aoeui/aoeui-1.6.tgz"
  sha256 "0655c3ca945b75b1204c5f25722ac0a07e89dd44bbf33aca068e918e9ef2a825"
  license "GPL-2.0-only"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/aoeui"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a40643b902ea2af8c9331c42e5311e6258bb6814dec8cbedc10852f93cff31de"
  end

  uses_from_macos "m4" => :build

  def install
    system "make", "INST_DIR=#{prefix}", "install"
  end
end
