class Clpbar < Formula
  desc "Command-line progress bar"
  homepage "https://clpbar.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/clpbar/clpbar/bar-1.11.1/bar_1.11.1.tar.gz"
  sha256 "fa0f5ec5c8400316c2f4debdc6cdcb80e186e668c2e4471df4fec7bfcd626503"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/clpbar"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "0a288f6e05728d57b77dcc64d47d90bcac8d965b68e6af3615360beb74d4f1cb"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--program-prefix='clp'"
    system "make", "install"
  end

  test do
    output = pipe_output("#{bin}/clpbar 2>&1", shell_output("dd if=/dev/zero bs=1024 count=5"))
    assert_match "Copied: 5120B (5.0KB)", output
  end
end
