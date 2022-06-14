class Ired < Formula
  desc "Minimalistic hexadecimal editor designed to be used in scripts"
  homepage "https://github.com/radare/ired"
  url "https://github.com/radare/ired/archive/0.6.tar.gz"
  sha256 "c15d37b96b1a25c44435d824bd7ef1f9aea9dc191be14c78b689d3156312d58a"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ired"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a52a7490a9b868162515ea16e2be3ff9c6b00c27cc76e3b1915792d57143667f"
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    input = <<~EOS
      w"hello wurld"
      s+7
      r-4
      w"orld"
      q
    EOS
    pipe_output("#{bin}/ired test.text", input)
    assert_equal "hello world", (testpath/"test.text").read.chomp
  end
end
