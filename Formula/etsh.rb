class Etsh < Formula
  desc "Two ports of /bin/sh from V6 UNIX (circa 1975)"
  homepage "https://etsh.nl/"
  url "https://etsh.nl/src/etsh_5.4.0/etsh-5.4.0.tar.xz"
  sha256 "fd4351f50acbb34a22306996f33d391369d65a328e3650df75fb3e6ccacc8dce"
  version_scheme 1

  livecheck do
    url "https://etsh.nl/src/"
    regex(/href=.*?etsh[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/etsh"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7ddbf283676699c6577d40a9e72cfd38f30be0217e15b3ed66ca96824a2cfefa"
  end

  conflicts_with "omake", because: "both install `osh` binaries"
  conflicts_with "teleport", because: "both install `tsh` binaries"

  def install
    system "./configure"
    # The `tshall` target is not supported on Ubuntu 16.04 (https://etsh.nl/blog/ubuntu-16/)
    # so the `install-etshall` target must be used to only build `etshall`.
    # Check if `tshall` is supported in Ubuntu 18.04.
    install_target = OS.mac? ? "install" : "install-etshall"
    system "make", install_target, "PREFIX=#{prefix}", "SYSCONFDIR=#{etc}", "MANDIR=#{man1}"
    bin.install_symlink "etsh" => "osh"
    bin.install_symlink "tsh" => "sh6" if OS.mac?
  end

  test do
    assert_match "brew!", shell_output("#{bin}/etsh -c 'echo brew!'").strip
  end
end
