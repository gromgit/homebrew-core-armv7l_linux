class Libextractor < Formula
  desc "Library to extract meta data from files"
  homepage "https://www.gnu.org/software/libextractor/"
  url "https://ftp.gnu.org/gnu/libextractor/libextractor-1.11.tar.gz"
  mirror "https://ftpmirror.gnu.org/libextractor/libextractor-1.11.tar.gz"
  sha256 "16f633ab8746a38547c4a1da3f4591192b0825ad83c4336f0575b85843d8bd8f"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libextractor"
    sha256 armv7l_linux: "bb45da532ddf8783dabd9c5bc4bf316cf02cecefbc1448cf2ebae08fd5e70d9b"
  end

  depends_on "pkg-config" => :build
  depends_on "libtool"

  uses_from_macos "zlib"

  conflicts_with "csound", because: "both install `extract` binaries"
  conflicts_with "pkcrack", because: "both install `extract` binaries"

  def install
    ENV.deparallelize

    system "./configure", "--disable-silent-rules",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    fixture = test_fixtures("test.png")
    assert_match "Keywords for file", shell_output("#{bin}/extract #{fixture}")
  end
end
