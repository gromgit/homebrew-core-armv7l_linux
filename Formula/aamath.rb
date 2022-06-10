class Aamath < Formula
  desc "Renders mathematical expressions as ASCII art"
  homepage "http://fuse.superglue.se/aamath/"
  url "http://fuse.superglue.se/aamath/aamath-0.3.tar.gz"
  sha256 "9843f4588695e2cd55ce5d8f58921d4f255e0e65ed9569e1dcddf3f68f77b631"
  license "GPL-2.0-only"

  livecheck do
    url :homepage
    regex(/href=.*?aamath[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/aamath"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "046cc2a3104d914da8c67d11d28a5d545a0526a66aa1b2e6d93c2abcb463c161"
  end

  uses_from_macos "bison" => :build # for yacc
  uses_from_macos "flex" => :build

  on_linux do
    depends_on "readline"
  end

  # Fix build on clang; patch by Homebrew team
  # https://github.com/Homebrew/homebrew/issues/23872
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/85fa66a9/aamath/0.3.patch"
    sha256 "9443881d7950ac8d2da217a23ae3f2c936fbd6880f34dceba717f1246d8608f1"
  end

  def install
    ENV.deparallelize
    system "make"

    bin.install "aamath"
    man1.install "aamath.1"
    prefix.install "testcases"
  end

  test do
    s = pipe_output("#{bin}/aamath", (prefix/"testcases").read)
    assert_match "f(x + h) = f(x) + h f'(x)", s
  end
end
