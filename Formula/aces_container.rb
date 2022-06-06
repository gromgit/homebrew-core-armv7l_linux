class AcesContainer < Formula
  desc "Reference implementation of SMPTE ST2065-4"
  homepage "https://github.com/ampas/aces_container"
  url "https://github.com/ampas/aces_container/archive/v1.0.2.tar.gz"
  sha256 "cbbba395d2425251263e4ae05c4829319a3e399a0aee70df2eb9efb6a8afdbae"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/aces_container"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b08e8f89d31f76ee7166d87814d8d93a5e216a97666c56cfe4a4ab146417bf60"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "aces/aces_Writer.h"

      int main()
      {
          aces_Writer x;
          return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lAcesContainer", "-o", "test"
    system "./test"
  end
end
