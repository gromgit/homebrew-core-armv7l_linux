class Mp3wrap < Formula
  desc "Wrap two or more mp3 files in a single large file"
  homepage "https://mp3wrap.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/mp3wrap/mp3wrap/mp3wrap%200.5/mp3wrap-0.5-src.tar.gz"
  sha256 "1b4644f6b7099dcab88b08521d59d6f730fa211b5faf1f88bd03bf61fedc04e7"

  livecheck do
    url :stable
    regex(%r{url=.*?/mp3wrap[._-]v?(\d+(?:\.\d+)+)(?:-src)?\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mp3wrap"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "44fefd5e0e541bb5dd6fc9f6aff961b37deb8d65f2721d50deb4074dacde45b6"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    source = test_fixtures("test.mp3")
    system "#{bin}/mp3wrap", "#{testpath}/t.mp3", source, source
    assert_predicate testpath/"t_MP3WRAP.mp3", :exist?
  end
end
