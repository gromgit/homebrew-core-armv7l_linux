class Jthread < Formula
  desc "C++ class to make use of threads easy"
  homepage "https://research.edm.uhasselt.be/jori/page/CS/Jthread.html"
  url "https://research.edm.uhasselt.be/jori/jthread/jthread-1.3.3.tar.bz2"
  sha256 "17560e8f63fa4df11c3712a304ded85870227b2710a2f39692133d354ea0b64f"

  livecheck do
    url :homepage
    regex(/href=.*?jthread[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jthread"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "28cc645d8fd9739fe0ff22652e9bd8ab5fddc638e54d4b9791a220b177dd1e19"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <jthread/jthread.h>
      using namespace jthread;

      int main() {
        JMutex* jm = new JMutex();
        jm->Init();
        jm->Lock();
        jm->Unlock();
        return 0;
      }
    EOS

    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-ljthread",
                    "-o", "test"
    system "./test"
  end
end
