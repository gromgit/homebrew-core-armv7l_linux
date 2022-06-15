class Libtextcat < Formula
  desc "N-gram-based text categorization library"
  homepage "https://software.wise-guys.nl/libtextcat/"
  url "https://software.wise-guys.nl/download/libtextcat-2.2.tar.gz"
  mirror "https://src.fedoraproject.org/repo/pkgs/libtextcat/libtextcat-2.2.tar.gz/128cfc86ed5953e57fe0f5ae98b62c2e/libtextcat-2.2.tar.gz"
  sha256 "5677badffc48a8d332e345ea4fe225e3577f53fc95deeec8306000b256829655"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?libtextcat[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libtextcat"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "75b5c67b3b379f876912519217af0cb1bed2e645228b5c96f8a0ac8f51cc4c76"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-ivf"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
    (include/"libtextcat/").install Dir["src/*.h"]
    share.install "langclass/LM", "langclass/ShortTexts", "langclass/conf.txt"
  end

  test do
    output = pipe_output(bin/"createfp", "abcdefghijklmnopqrstuvwxyz").lines
    expected = %w[
      _ rstuv opqr mno nopqr g y b c d e f u h i j k l m n o p q r s t xyz v w x a z lmnop efg jklmn hijkl defg fghij
      defgh hijk vwx bcdef lmno nop pqrs fgh tuvw xyz_ wxy opq ghi cdef _ab ghij nopq klmn pqr _a _abcd ab _abc bc
      pqrst cd hij de ef fg gh hi ij jk stuv kl lm mn wxyz_ no op pq qr uvwxy yz_ rs wxyz st tu uv stuvw vw wx xy yz
      z_ qrstu qrs opqrs mnopq ijk klmno bcde ijklm abc ghijk fghi efghi cdefg jklm abcde rst uvw jkl rstu bcd vwxy
      stu klm abcd cde efgh ijkl tuv mnop lmn qrst def uvwx vwxyz tuvwx
    ].map! { |line| "#{line}\n" }

    assert_equal expected, output
  end
end
