class Cpulimit < Formula
  desc "CPU usage limiter"
  homepage "https://github.com/opsengine/cpulimit"
  url "https://github.com/opsengine/cpulimit/archive/v0.2.tar.gz"
  sha256 "64312f9ac569ddcadb615593cd002c94b76e93a0d4625d3ce1abb49e08e2c2da"
  license "GPL-2.0"
  head "https://github.com/opsengine/cpulimit.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cpulimit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "009b4b03beaff1f3233fe42606739454ce22e85877fdc2f6da391d6547eb661c"
  end

  def install
    system "make"
    bin.install "src/cpulimit"
  end

  test do
    system "#{bin}/cpulimit", "--limit=10", "ls"
  end
end
