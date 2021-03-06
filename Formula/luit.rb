class Luit < Formula
  desc "Filter run between arbitrary application and UTF-8 terminal emulator"
  homepage "https://invisible-island.net/luit/"
  url "https://invisible-mirror.net/archives/luit/luit-20220111.tgz"
  sha256 "86c07a4ff2d4374a655a1eef2ec7504582d42bba5971c79b111364e2b26ed468"
  license "MIT"

  livecheck do
    url "https://invisible-mirror.net/archives/luit/"
    regex(/href=.*?luit[._-]v?(\d+(?:[.-]\d+)*)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/luit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a90faac13e851013f54ea9a08728bf718b275388408764c69d5af6e122b74ac0"
  end

  uses_from_macos "zlib"

  def install
    system "./configure", "--prefix=#{prefix}", "--without-x"
    system "make", "install"
  end

  test do
    require "pty"
    (testpath/"input").write("#end {bye}\n")
    PTY.spawn(bin/"luit", "-encoding", "GBK", "echo", "foobar") do |r, _w, _pid|
      assert_match "foobar", r.read
    rescue Errno::EIO
      # GNU/Linux raises EIO when read is done on closed pty
    end
  end
end
