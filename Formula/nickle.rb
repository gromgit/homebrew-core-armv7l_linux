class Nickle < Formula
  desc "Desk calculator language"
  homepage "https://www.nickle.org/"
  url "https://www.nickle.org/release/nickle-2.90.tar.gz"
  sha256 "fbb3811aa0ac4b31e1702ea643dd3a6a617b2516ad6f9cfab76ec2779618e5a4"
  license "MIT"

  livecheck do
    url "https://www.nickle.org/release/"
    regex(/href=.*?nickle[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/nickle"
    rebuild 1
    sha256 armv7l_linux: "af164c29be41eecf04efc24c7263a746986c1b9b60813e12092b0966a6803d1a"
  end

  depends_on "readline"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "4", shell_output("#{bin}/nickle -e '2+2'").chomp
  end
end
