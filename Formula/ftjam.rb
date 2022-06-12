class Ftjam < Formula
  desc "Build tool that can be used as a replacement for Make"
  homepage "https://www.freetype.org/jam/"
  url "https://downloads.sourceforge.net/project/freetype/ftjam/2.5.2/ftjam-2.5.2.tar.bz2"
  sha256 "e89773500a92912de918e9febffabe4b6bce79d69af194435f4e032b8a6d66a3"
  license :cannot_represent

  # We check the "ftjam" directory page since versions aren't present in the
  # RSS feed as of writing.
  livecheck do
    url "https://sourceforge.net/projects/freetype/files/ftjam/"
    strategy :page_match
    regex(%r{href=.*?/v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ftjam"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "651abcfce41fa10eb46dae139eeea6dfe3f5a9e858b4c54c6bd1a385b34d1eb7"
  end

  uses_from_macos "bison" => :build

  conflicts_with "jam", because: "both install a `jam` binary"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"Jamfile").write <<~EOS
      Main ftjamtest : ftjamtest.c ;
    EOS

    (testpath/"ftjamtest.c").write <<~EOS
      #include <stdio.h>

      int main(void)
      {
          printf("FtJam Test\\n");
          return 0;
      }
    EOS

    assert_match "Cc ftjamtest.o", shell_output(bin/"jam")
    assert_equal "FtJam Test\n", shell_output("./ftjamtest")
  end
end
