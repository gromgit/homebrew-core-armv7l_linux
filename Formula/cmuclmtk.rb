class Cmuclmtk < Formula
  desc "Language model tools (from CMU Sphinx)"
  homepage "https://cmusphinx.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/cmusphinx/cmuclmtk/0.7/cmuclmtk-0.7.tar.gz"
  sha256 "d23e47f00224667c059d69ac942f15dc3d4c3dd40e827318a6213699b7fa2915"

  # We check the "cmuclmtk" directory page since versions aren't present in the
  # RSS feed as of writing.
  livecheck do
    url "https://sourceforge.net/projects/cmusphinx/files/cmuclmtk/"
    strategy :page_match
    regex(%r{href=.*?/v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cmuclmtk"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "47cd08b5be7c641ce7129929e381887359f363d0c8654c7ee7787e9ed2292aac"
  end

  depends_on "pkg-config" => :build

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
