class Bbe < Formula
  desc "Sed-like editor for binary files"
  homepage "https://sourceforge.net/projects/bbe-/"
  url "https://downloads.sourceforge.net/project/bbe-/bbe/0.2.2/bbe-0.2.2.tar.gz"
  sha256 "baaeaf5775a6d9bceb594ea100c8f45a677a0a7d07529fa573ba0842226edddb"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bbe"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "0b80881c747dccb2ef6b2a4a4fdcd2726697eba591ed87101f6a3df1fe2ef499"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/bbe", "--version"
  end
end
