class Alac < Formula
  desc "Basic decoder for Apple Lossless Audio Codec files (ALAC)"
  homepage "https://web.archive.org/web/20150319040222/craz.net/programs/itunes/alac.html"
  url "https://web.archive.org/web/20150510210401/craz.net/programs/itunes/files/alac_decoder-0.2.0.tgz"
  sha256 "7f8f978a5619e6dfa03dc140994fd7255008d788af848ba6acf9cfbaa3e4122f"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/alac"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "81381643cd81f40e9d8257e6f07f75376904753b42720c8786eb907b4519a7ed"
  end

  def install
    system "make", "CFLAGS=#{ENV.cflags}", "CC=#{ENV.cc}"
    bin.install "alac"
  end

  test do
    sample = test_fixtures("test.m4a")
    assert_equal "file type: mp4a\n", shell_output("#{bin}/alac -t #{sample}", 100)
  end
end
