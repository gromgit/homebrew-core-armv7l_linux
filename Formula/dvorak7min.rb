class Dvorak7min < Formula
  desc "Dvorak (simplified keyboard layout) typing tutor"
  homepage "https://web.archive.org/web/dvorak7min.sourcearchive.com/"
  url "https://deb.debian.org/debian/pool/main/d/dvorak7min/dvorak7min_1.6.1+repack.orig.tar.gz"
  version "1.6.1"
  sha256 "4cdef8e4c8c74c28dacd185d1062bfa752a58447772627aded9ac0c87a3b8797"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dvorak7min"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "0e5b90d9062008e8d471b81a69c11913eeb3e4a6361af4eac445f979731e6f41"
  end

  uses_from_macos "ncurses"

  def install
    # Remove pre-built ELF binary first
    system "make", "clean"
    system "make"
    system "make", "INSTALL=#{bin}", "install"
  end
end
