class Mawk < Formula
  desc "Interpreter for the AWK Programming Language"
  homepage "https://invisible-island.net/mawk/"
  url "https://invisible-mirror.net/archives/mawk/mawk-1.3.4-20200120.tgz"
  sha256 "7fd4cd1e1fae9290fe089171181bbc6291dfd9bca939ca804f0ddb851c8b8237"
  license "GPL-2.0"

  livecheck do
    url "https://invisible-mirror.net/archives/mawk/?C=M&O=D"
    regex(/href=.*?mawk[._-]v?(\d+(?:\.\d+)+(?:-\d+)?)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mawk"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3aabb3da5ce95da1ae6de2b63cd80526000a5b6a448198cb16fb22951d164cf1"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-silent-rules",
                          "--with-readline=/usr/lib",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    mawk_expr = '/^mawk / {printf("%s-%s", $2, $3)}'
    ver_out = pipe_output("#{bin}/mawk '#{mawk_expr}'", shell_output("#{bin}/mawk -W version 2>&1"))
    assert_equal version.to_s, ver_out
  end
end
