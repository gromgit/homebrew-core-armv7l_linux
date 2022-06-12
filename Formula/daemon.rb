class Daemon < Formula
  desc "Turn other processes into daemons"
  homepage "https://libslack.org/daemon/"
  url "https://libslack.org/daemon/download/daemon-0.8.tar.gz"
  sha256 "74f12e6d4b3c85632489bd08431d3d997bc17264bf57b7202384f2e809cff596"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?daemon[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/daemon"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b47cfc21fe9a10077c5c44ece48a6b952fdcf1def85bdf78e252be583d248041"
  end

  def install
    system "./configure"
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "#{bin}/daemon", "--version"
  end
end
