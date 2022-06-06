class Gperf < Formula
  desc "Perfect hash function generator"
  homepage "https://www.gnu.org/software/gperf"
  url "https://ftp.gnu.org/gnu/gperf/gperf-3.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/gperf/gperf-3.1.tar.gz"
  sha256 "588546b945bba4b70b6a3a616e80b4ab466e3f33024a352fc2198112cdbb3ae2"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gperf"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "83db055fc06b89a0de0901a8b65f103746805cc2a749b4340ccd7047a0f029a1"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "TOTAL_KEYWORDS 3",
      pipe_output("#{bin}/gperf", "homebrew\nfoobar\ntest\n")
  end
end
