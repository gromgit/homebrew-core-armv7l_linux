class Openlibm < Formula
  desc "High quality, portable, open source libm implementation"
  homepage "https://openlibm.org"
  url "https://github.com/JuliaMath/openlibm/archive/v0.8.1.tar.gz"
  sha256 "ba8a282ecd92d0033f5656bb20dfc6ea3fb83f90ba69291ac8f7beba42dcffcf"
  license all_of: ["MIT", "ISC", "BSD-2-Clause"]

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/openlibm"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "96e4a2b38f2af922fb867b235e1fa4a2b4a7a81c12d96eea90e4ca28adb23620"
  end

  def install
    lib.mkpath
    (lib/"pkgconfig").mkpath
    (include/"openlibm").mkpath

    system "make", "install", "prefix=#{prefix}"

    lib.install Dir["lib/*"].reject { |f| File.directory? f }
    (lib/"pkgconfig").install Dir["lib/pkgconfig/*"]
    (include/"openlibm").install Dir["include/openlibm/*"]
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include "openlibm.h"
      int main (void) {
        printf("%.1f", cos(acos(0.0)));
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}/openlibm",
           "-o", "test"
    assert_equal "0.0", shell_output("./test")
  end
end
