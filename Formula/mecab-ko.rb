class MecabKo < Formula
  desc "See mecab"
  homepage "https://bitbucket.org/eunjeon/mecab-ko"
  url "https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz"
  version "0.996-ko-0.9.2"
  sha256 "d0e0f696fc33c2183307d4eb87ec3b17845f90b81bf843bd0981e574ee3c38cb"

  livecheck do
    url :stable
    regex(/href=.*?mecab[._-]v?(\d+(?:\.\d+)+-ko-\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mecab-ko"
    rebuild 2
    sha256 armv7l_linux: "9cbede9feb521f4f02d31422e386f12679ed95fb2d0d2e2f362918918bf44705"
  end

  conflicts_with "mecab", because: "both install mecab binaries"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"
    system "make", "install"

    # Put dic files in HOMEBREW_PREFIX/lib instead of lib
    inreplace "#{bin}/mecab-config", "${exec_prefix}/lib/mecab/dic", "#{HOMEBREW_PREFIX}/lib/mecab/dic"
    inreplace "#{etc}/mecabrc", "#{lib}/mecab/dic", "#{HOMEBREW_PREFIX}/lib/mecab/dic"
  end

  def post_install
    (HOMEBREW_PREFIX/"lib/mecab/dic").mkpath
  end

  test do
    assert_equal "#{HOMEBREW_PREFIX}/lib/mecab/dic", shell_output("#{bin}/mecab-config --dicdir").chomp
  end
end
