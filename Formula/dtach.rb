class Dtach < Formula
  desc "Emulates the detach feature of screen"
  homepage "https://dtach.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/dtach/dtach/0.9/dtach-0.9.tar.gz"
  sha256 "32e9fd6923c553c443fab4ec9c1f95d83fa47b771e6e1dafb018c567291492f3"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dtach"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "6e19cc31d63c15ffcd6d53e68a57450bc803c71574ba4083c8a4131a79410b3e"
  end

  def install
    # Includes <config.h> instead of "config.h", so "." needs to be in the include path.
    ENV.append "CFLAGS", "-I."

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make"
    bin.install "dtach"
    man1.install gzip("dtach.1")
  end

  test do
    system bin/"dtach", "--help"
  end
end
