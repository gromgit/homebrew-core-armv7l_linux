class Dwarf < Formula
  desc "Object file manipulation tool"
  homepage "https://github.com/elboza/dwarf-ng/"
  url "https://github.com/elboza/dwarf-ng/archive/dwarf-0.4.0.tar.gz"
  sha256 "a64656f53ded5166041ae25cc4b1ad9ab5046a5c4d4c05b727447e73c0d83da0"
  license "GPL-2.0"
  revision 1

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dwarf"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f09935c45d17012847dd21efea5d95a54fd02670b012bddea28533e4f876e365"
  end

  depends_on "flex"
  depends_on "readline"

  uses_from_macos "bison"

  def install
    %w[src/libdwarf.c doc/dwarf.man doc/xdwarf.man.html].each do |f|
      inreplace f, "/etc/dwarfrc", etc/"dwarfrc"
    end

    system "make"
    system "make", "install", "BINDIR=#{bin}", "MANDIR=#{man1}"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>

      int main(int argc, char *argv[]) {
        printf("hello world\\n");
      }
    EOS
    system ENV.cc, "test.c", "-o", "test"
    if OS.mac?
      output = shell_output("#{bin}/dwarf -c 'pp $mac' test")
      assert_equal "magic: 0xfeedfacf (-17958193)", output.lines[0].chomp
    else
      assert_match "main header: elf", shell_output("#{bin}/dwarf -p test")
    end
  end
end
