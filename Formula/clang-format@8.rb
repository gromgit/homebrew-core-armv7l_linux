class ClangFormatAT8 < Formula
  desc "Formatting tools for C, C++, Obj-C, Java, JavaScript, TypeScript"
  homepage "https://clang.llvm.org/docs/ClangFormat.html"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-8.0.1/llvm-8.0.1.src.tar.xz"
  sha256 "44787a6d02f7140f145e2250d56c9f849334e11f9ae379827510ed72f12b75e7"
  license "Apache-2.0"
  revision 1

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/clang-format@8"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "64ac4acd53dd1b753d74402b15e78c3233b28c5e67b1fdd9cdef9c5db61586ec"
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  resource "clang" do
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-8.0.1/cfe-8.0.1.src.tar.xz"
    sha256 "70effd69f7a8ab249f66b0a68aba8b08af52aa2ab710dfb8a0fba102685b1646"
  end

  def install
    (buildpath/"tools/clang").install resource("clang")

    mkdir buildpath/"build" do
      args = std_cmake_args
      args << ".."
      system "cmake", "-G", "Ninja", *args
      system "ninja", "clang-format"
    end

    bin.install buildpath/"build/bin/clang-format" => "clang-format-8"
    bin.install buildpath/"tools/clang/tools/clang-format/git-clang-format" => "git-clang-format-8"
  end

  test do
    # NB: below C code is messily formatted on purpose.
    (testpath/"test.c").write <<~EOS
      int         main(char *args) { \n   \t printf("hello"); }
    EOS

    assert_equal "int main(char *args) { printf(\"hello\"); }\n",
        shell_output("#{bin}/clang-format-8 -style=Google test.c")
  end
end
