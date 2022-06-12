class Dmagnetic < Formula
  desc "Magnetic Scrolls Interpreter"
  homepage "https://www.dettus.net/dMagnetic/"
  url "https://www.dettus.net/dMagnetic/dMagnetic_0.34.tar.bz2"
  sha256 "570b1beb7111874cfbb54fc71868dccc732bc3235b9e5df586d93a4ff2b8e897"
  license "BSD-2-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?dMagnetic[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dmagnetic"
    sha256 armv7l_linux: "fec20beb58938ede9c6c789f2890ee90b2733fab05ab31770f8a2d8c38fefa75"
  end

  def install
    # Look for configuration and other data within the Homebrew prefix rather than the default paths
    inreplace "src/toplevel/dMagnetic_pathnames.h" do |s|
      s.gsub! "/etc/", "#{etc}/"
      s.gsub! "/usr/local/", "#{HOMEBREW_PREFIX}/"
    end

    system "make", "PREFIX=#{prefix}", "install"
    (share/"games/dMagnetic").install "testcode/minitest.mag", "testcode/minitest.gfx"
  end

  test do
    args = %W[
      -vmode none
      -vcols 300
      -vrows 300
      -vecho -sres 1024x768
      -mag #{share}/games/dMagnetic/minitest.mag
      -gfx #{share}/games/dMagnetic/minitest.gfx
    ]
    command_output = pipe_output("#{bin}/dMagnetic #{args.join(" ")}", "Hello\n")
    assert_match(/^Virtual machine is running\..*\n> HELLO$/, command_output)
  end
end
