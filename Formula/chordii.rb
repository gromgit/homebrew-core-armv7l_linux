class Chordii < Formula
  desc "Text file to music sheet converter"
  homepage "https://www.vromans.org/johan/projects/Chordii/"
  url "https://downloads.sourceforge.net/project/chordii/chordii/4.5/chordii-4.5.3b.tar.gz"
  sha256 "edb19be9de456366e592a75a5ce1c0a75352a55d5b4e5f282c953c7e7f2d87b5"
  license "GPL-3.0"

  livecheck do
    url :stable
    regex(%r{url=.*?/chordii[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/chordii"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "54536c10a224fd65acfe131c01cdc786a0d01d5846d5720a7e9430da3a71795b"
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"homebrew.cho").write <<~EOS
      {title:Homebrew}
      {subtitle:I can't write lyrics. Send help}

      [C]Thank [G]You [F]Everyone,
      [C]We couldn't maintain [F]Homebrew without you,
      [G]Here's an appreciative song from us to [C]you.
    EOS

    system bin/"chordii", "--output=#{testpath}/homebrew.ps", "homebrew.cho"
    assert_predicate testpath/"homebrew.ps", :exist?
  end
end
