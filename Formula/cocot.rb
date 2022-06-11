class Cocot < Formula
  desc "Code converter on tty"
  homepage "https://vmi.jp/software/cygwin/cocot.html"
  url "https://github.com/vmi/cocot/archive/cocot-1.2-20171118.tar.gz"
  sha256 "b718630ce3ddf79624d7dcb625fc5a17944cbff0b76574d321fb80c61bb91e4c"
  license "BSD-3-Clause"
  head "https://github.com/vmi/cocot.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cocot"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b01db46fd3b24c8d2ed2428074926ccc8682d1c95c5cbd9d2a4d8d2784b90f69"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
