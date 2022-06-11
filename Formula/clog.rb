class Clog < Formula
  desc "Colorized pattern-matching log tail utility"
  homepage "https://taskwarrior.org/docs/clog/"
  url "https://gothenburgbitfactory.org/download/clog-1.3.0.tar.gz"
  sha256 "fed44a8d398790ab0cf426c1b006e7246e20f3fcd56c0ec4132d24b05d5d2018"
  license "MIT"
  head "https://github.com/GothenburgBitFactory/clog.git", branch: "1.4.0"

  livecheck do
    url "https://gothenburgbitfactory.org"
    regex(/href=.*?clog[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/clog"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b51ee89fbc9a1ab99f2c5cd786f6be9d01c2faaa18f46dd1285609b4e0ddbef1"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  def caveats
    <<~EOS
      Next step is to create a .clogrc file in your home directory. See 'man clog'
      for details and a sample file.
    EOS
  end

  test do
    # Create a rule to suppress any line containing the word 'ignore'
    (testpath/".clogrc").write "default rule /ignore/       --> suppress"

    # Test to ensure that a line that does not match the above rule is not suppressed
    assert_equal "do not suppress", pipe_output("#{bin}/clog --file #{testpath}/.clogrc", "do not suppress").chomp

    # Test to ensure that a line that matches the above rule is suppressed
    assert_equal "", pipe_output("#{bin}/clog --file #{testpath}/.clogrc", "ignore this line").chomp
  end
end
