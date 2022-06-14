class Latino < Formula
  desc "Lenguaje de programación de código abierto para latinos y de habla hispana"
  homepage "https://www.lenguajelatino.org/"
  url "https://github.com/lenguaje-latino/latino.git",
      tag:      "v1.4.1",
      revision: "3ec6ab29902acb0b353cfe9a7b5d0317785fbd88"
  license "MIT"
  head "https://github.com/lenguaje-latino/latino.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/latino"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "53fb72b15648a5aa48a8bc8b86c8b25908595d504a1aef73baea99be046d805e"
  end

  depends_on "cmake" => :build

  on_linux do
    depends_on "readline"
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test1.lat").write "poner('hola mundo')"
    (testpath/"test2.lat").write <<~EOS
      desde (i = 0; i <= 10; i++)
        escribir(i)
      fin
    EOS
    output = shell_output("#{bin}/latino test1.lat")
    assert_equal "hola mundo", output.chomp
    output2 = shell_output("#{bin}/latino test2.lat")
    assert_equal "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10", output2.chomp
  end
end
