class Aerc < Formula
  desc "Email client that runs in your terminal"
  homepage "https://aerc-mail.org/"
  url "https://git.sr.ht/~rjarry/aerc/archive/0.10.0.tar.gz"
  sha256 "14d6c622a012069deb1a31b51ecdd187fd11041c8e46f396ac22830b00e4c114"
  license "MIT"
  head "https://git.sr.ht/~rjarry/aerc", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/aerc"
    rebuild 1
    sha256 armv7l_linux: "e58b898cf02816248b6ecdd53ee8d7215d3e90af9cd713b7e152504739ef3ebc"
  end

  depends_on "go" => :build
  depends_on "scdoc" => :build

  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/aerc", "-v"
  end
end
