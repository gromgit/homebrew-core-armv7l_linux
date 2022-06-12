class Doublecpp < Formula
  desc "Double dispatch in C++"
  homepage "https://doublecpp.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/doublecpp/doublecpp/0.6.3/doublecpp-0.6.3.tar.gz"
  sha256 "232f8bf0d73795558f746c2e77f6d7cb54e1066cbc3ea7698c4fba80983423af"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/doublecpp"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "97b2a27f2aed8b14969527a22c0b4bfa6684bcee075ad6cb4ecf90d1078f245b"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/doublecpp", "--version"
  end
end
