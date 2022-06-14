# Version is "pre-release", but is what Debian, MacPorts, etc.
# package, and upstream has not had any movement in a long time.
class Iftop < Formula
  desc "Display an interface's bandwidth usage"
  homepage "https://www.ex-parrot.com/~pdw/iftop/"
  url "https://www.ex-parrot.com/pdw/iftop/download/iftop-1.0pre4.tar.gz"
  sha256 "f733eeea371a7577f8fe353d86dd88d16f5b2a2e702bd96f5ffb2c197d9b4f97"
  license "GPL-2.0"

  # We have to allow the regex to match prerelease versions (e.g., 1.0pre4)
  # until there's a new stable version. The newest version was released on
  # 2014-01-19, so it could be a while.
  livecheck do
    url "https://www.ex-parrot.com/pdw/iftop/download/"
    regex(/href=.*?iftop[._-]v?(\d+(?:\.\d+)+(?:pre\d+)?)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/iftop"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "725fc10b46f76a05a36544a0f03215ac88b98f618375aabe57206a0a250b9140"
  end

  head do
    url "https://code.blinkace.com/pdw/iftop.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  uses_from_macos "libpcap"
  uses_from_macos "ncurses"

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  def caveats
    <<~EOS
      iftop requires root privileges so you will need to run `sudo iftop`.
      You should be certain that you trust any software you grant root privileges.
    EOS
  end

  test do
    assert_match "interface:", pipe_output("#{sbin}/iftop -t -s 1 2>&1")
  end
end
