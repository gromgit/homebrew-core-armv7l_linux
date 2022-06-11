class Bitwise < Formula
  desc "Terminal based bit manipulator in ncurses"
  homepage "https://github.com/mellowcandle/bitwise"
  url "https://github.com/mellowcandle/bitwise/releases/download/v0.43/bitwise-v0.43.tar.gz"
  sha256 "f524f794188a10defc4df673d8cf0b3739f93e58e93aff0cdb8a99fbdcca2ffb"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bitwise"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "49341126bd1ecd0e1cd7c4e97e1a88846bd20830742c45d50c5f4ba961944657"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "readline"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    assert_match "0 0 1 0 1 0 0 1", shell_output("#{bin}/bitwise --no-color '0x29A >> 4'")
  end
end
