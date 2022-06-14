class Jrtplib < Formula
  desc "Fully featured C++ Library for RTP (Real-time Transport Protocol)"
  homepage "https://research.edm.uhasselt.be/jori/jrtplib"
  url "https://research.edm.uhasselt.be/jori/jrtplib/jrtplib-3.11.2.tar.bz2"
  sha256 "2c01924c1f157fb1a4616af5b9fb140acea39ab42bfb28ac28d654741601b04c"

  livecheck do
    skip "No longer developed"
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jrtplib"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "76de3e891ded0aba305ad741a8e1e1aba12b2d38123a5d32f8a1411c387aa553"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "jthread"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <jrtplib3/rtpsessionparams.h>
      using namespace jrtplib;
      int main() {
        RTPSessionParams sessionparams;
        sessionparams.SetOwnTimestampUnit(1.0/8000.0);
        return 0;
      }
    EOS

    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-ljrtp",
                    "-o", "test"
    system "./test"
  end
end
