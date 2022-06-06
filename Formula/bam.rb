class Bam < Formula
  desc "Build system that uses Lua to describe the build process"
  homepage "https://matricks.github.io/bam/"
  url "https://github.com/matricks/bam/archive/v0.5.1.tar.gz"
  sha256 "cc8596af3325ecb18ebd6ec2baee550e82cb7b2da19588f3f843b02e943a15a9"
  license "Zlib"
  head "https://github.com/matricks/bam.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bam"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "0f14977d5f7ddefc311735b360529fdcefd53b0d49c3de6042430d4959e281cd"
  end

  def install
    system "./make_unix.sh"
    bin.install "bam"
  end

  test do
    (testpath/"hello.c").write <<~EOS
      #include <stdio.h>
      int main() {
        printf("hello\\n");
        return 0;
      }
    EOS

    (testpath/"bam.lua").write <<~EOS
      settings = NewSettings()
      objs = Compile(settings, Collect("*.c"))
      exe = Link(settings, "hello", objs)
    EOS

    system bin/"bam", "-v"
    assert_equal "hello", shell_output("./hello").chomp
  end
end
