class Cbmbasic < Formula
  desc "Commodore BASIC V2 as a scripting language"
  homepage "https://github.com/mist64/cbmbasic"
  url "https://downloads.sourceforge.net/project/cbmbasic/cbmbasic/1.0/cbmbasic-1.0.tgz"
  sha256 "2735dedf3f9ad93fa947ad0fb7f54acd8e84ea61794d786776029c66faf64b04"
  license "BSD-2-Clause"
  head "https://github.com/mist64/cbmbasic.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cbmbasic"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "9191e282b7f680a9c48691c7578146928625a43048b9024484493753b2d49367"
  end

  def install
    system "make", "CFLAGS=#{ENV.cflags}", "LDFLAGS=#{ENV.ldflags}"
    bin.install "cbmbasic"
  end

  test do
    assert_match(/READY.\r\n 1/, pipe_output("#{bin}/cbmbasic", "PRINT 1\n", 0))
  end
end
