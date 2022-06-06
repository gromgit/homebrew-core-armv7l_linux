class Brainfuck < Formula
  desc "Interpreter for the brainfuck language"
  homepage "https://github.com/fabianishere/brainfuck"
  url "https://github.com/fabianishere/brainfuck/archive/2.7.3.tar.gz"
  sha256 "d99be61271b4c27e26a8154151574aa3750133a0bedd07124b92ccca1e03b5a7"
  license "Apache-2.0"
  head "https://github.com/fabianishere/brainfuck.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/brainfuck"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "eb667c5eb0570b78d99f780977a5cc8a7306731358053452584e470ff1e11dc0"
  end

  depends_on "cmake" => :build

  uses_from_macos "libedit"

  def install
    system "cmake", ".", *std_cmake_args, "-DBUILD_SHARED_LIB=ON",
                         "-DBUILD_STATIC_LIB=ON", "-DINSTALL_EXAMPLES=ON"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/brainfuck -e '++++++++[>++++++++<-]>+.+.+.'")
    assert_equal "ABC", output.chomp
  end
end
