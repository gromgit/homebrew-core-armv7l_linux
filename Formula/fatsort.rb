class Fatsort < Formula
  desc "Sorts FAT16 and FAT32 partitions"
  homepage "https://fatsort.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/fatsort/fatsort-1.6.4.625.tar.xz"
  version "1.6.4"
  sha256 "9a6f89a0640bb782d82ff23a780c9f0aec3dfbe4682c0a8eda157e0810642ead"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/fatsort[._-]v?(\d+(?:\.\d+)+)\.\d+\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fatsort"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b46dd477262a2e92612877beb82f259bf87e78dcbf10e1a78881bb0ee4f1f074"
  end

  depends_on "help2man"

  def install
    system "make", "CC=#{ENV.cc}"
    bin.install "src/fatsort"
    man1.install "man/fatsort.1"
  end

  test do
    system "#{bin}/fatsort", "--version"
  end
end
