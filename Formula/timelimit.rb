class Timelimit < Formula
  desc "Limit a process's absolute execution time"
  homepage "https://devel.ringlet.net/sysutils/timelimit/"
  url "https://devel.ringlet.net/files/sys/timelimit/timelimit-1.9.2.tar.gz"
  sha256 "320a72770288b2deeb9abbd343f9c27afcb6190bb128ad2a1e1ee2a03a796d45"
  license "BSD-2-Clause"

  livecheck do
    url :homepage
    regex(/latest release is .*?timelimit[._-]v?(\d+(?:\.\d+)+)</i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/timelimit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ba6924b061304919853fbad03ca20eea1752faa048b2c9e394fd91006d5fc8c2"
  end

  def install
    # don't install for specific users
    inreplace "Makefile", "-o ${BINOWN} -g ${BINGRP}", ""
    inreplace "Makefile", "-o ${SHAREOWN} -g ${SHAREGRP}", ""

    args = %W[LOCALBASE=#{prefix} MANDIR=#{man}/man]

    check_args = args + ["check"]
    install_args = args + ["install"]

    system "make", *check_args
    system "make", *install_args
  end

  test do
    assert_match "timelimit: sending warning signal 15",
      shell_output("#{bin}/timelimit -p -t 1 sleep 5 2>&1", 143).chomp
  end
end
