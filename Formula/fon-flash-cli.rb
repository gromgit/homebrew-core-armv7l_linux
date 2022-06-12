class FonFlashCli < Formula
  desc "Flash La Fonera and Atheros chipset compatible devices"
  homepage "https://www.gargoyle-router.com/wiki/doku.php?id=fon_flash"
  url "https://github.com/ericpaulbishop/gargoyle/archive/1.13.0.tar.gz"
  sha256 "8086c5c0725f520b659eecca5784a9f0f25eb8eac0deafc967f0264977b3fbe1"
  license "GPL-2.0-or-later"
  head "https://github.com/ericpaulbishop/gargoyle.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fon-flash-cli"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7bf802c9ce3ec9abf83dfc78ef0e3bbcfd8ce09e4c420f0edac988633ae1f64b"
  end

  uses_from_macos "libpcap"

  def install
    cd "fon-flash" do
      system "make", "fon-flash"
      bin.install "fon-flash"
    end
  end

  test do
    system "#{bin}/fon-flash"
  end
end
