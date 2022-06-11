class Colortail < Formula
  desc "Like tail(1), but with various colors for specified output"
  homepage "https://github.com/joakim666/colortail"
  url "https://github.com/joakim666/colortail.git",
      revision: "f44fce0dbfd6bd38cba03400db26a99b489505b5"
  version "0.3.4"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/colortail"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "5b580835187ddd4367f3bddd799763bf176aec4538fbc3165bcf540d5fbfc298"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  # Upstream PR to fix the build on ML
  patch do
    url "https://github.com/joakim666/colortail/commit/36dd0437bb364fd1493934bdb618cc102a29d0a5.patch?full_index=1"
    sha256 "d799ddadeb652321f2bc443a885ad549fa0fe6e6cfc5d0104da5156305859dd3"
  end

  def install
    system "./autogen.sh", "--disable-dependency-tracking",
                           "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.txt").write "Hello\nWorld!\n"
    assert_match(/World!/, shell_output("#{bin}/colortail -n 1 test.txt"))
  end
end
