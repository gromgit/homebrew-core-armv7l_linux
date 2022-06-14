class Jam < Formula
  desc "Make-like build tool"
  homepage "https://www.perforce.com/documentation/jam-documentation"
  url "https://swarm.workshop.perforce.com/projects/perforce_software-jam/download/main/jam-2.6.1.zip"
  sha256 "72ea48500ad3d61877f7212aa3d673eab2db28d77b874c5a0b9f88decf41cb73"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jam"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "64cf78ed90a13d2294d827c1c1e0ec9bc18383fc58b9cc882ea2366e2f8c4bdf"
  end

  # The "Jam Documentation" page has a banner stating:
  # "Perforce is no longer actively contributing to the Jam Open Source project.
  # The last Perforce release of Jam was version 2.6 in August of 2014. We will
  # keep the Perforce-controlled links and information posted here available
  # until further notice."
  deprecate! date: "2021-07-10", because: :unmaintained

  conflicts_with "ftjam", because: "both install a `jam` binary"

  def install
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}", "LOCATE_TARGET=bin"
    bin.install "bin/jam", "bin/mkjambase"
  end

  test do
    (testpath/"Jamfile").write <<~EOS
      Main jamtest : jamtest.c ;
    EOS

    (testpath/"jamtest.c").write <<~EOS
      #include <stdio.h>

      int main(void)
      {
          printf("Jam Test\\n");
          return 0;
      }
    EOS

    assert_match "Cc jamtest.o", shell_output(bin/"jam")
    assert_equal "Jam Test", shell_output("./jamtest").strip
  end
end
