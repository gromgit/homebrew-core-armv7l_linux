class Hblock < Formula
  desc "Adblocker that creates a hosts file from multiple sources"
  homepage "https://hblock.molinero.dev/"
  url "https://github.com/hectorm/hblock/archive/v3.3.2.tar.gz"
  sha256 "35bd4af1dbae3b57de6cede6c05f3d4ce25227b33a53358ef47c76a491304eb0"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/hblock"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "31d98acdc362571796f04dee5c4fca5ed0949a5cf7347c024de713764f68a3c1"
  end

  uses_from_macos "curl"

  def install
    system "make", "install", "prefix=#{prefix}", "bindir=#{bin}", "mandir=#{man}"
  end

  test do
    output = shell_output("#{bin}/hblock -H none -F none -S none -A none -D none -qO-")
    assert_match "Blocked domains:", output
  end
end
