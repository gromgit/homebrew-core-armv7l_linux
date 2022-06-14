class Libunwind < Formula
  desc "C API for determining the call-chain of a program"
  homepage "https://www.nongnu.org/libunwind/"
  url "https://download.savannah.nongnu.org/releases/libunwind/libunwind-1.6.2.tar.gz"
  sha256 "4a6aec666991fb45d0889c44aede8ad6eb108071c3554fcdff671f9c94794976"
  license "MIT"

  livecheck do
    url "https://download.savannah.nongnu.org/releases/libunwind/"
    regex(/href=.*?libunwind[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libunwind"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "423afbb4046a7d5fa9d032c90897ed88fc7f95b6f9cc6185d06113bab7c5e696"
  end

  keg_only "libunwind conflicts with LLVM"

  depends_on :linux

  uses_from_macos "xz"
  uses_from_macos "zlib"

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libunwind.h>
      int main() {
        unw_context_t uc;
        unw_getcontext(&uc);
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "test.c", "-L#{lib}", "-lunwind", "-o", "test"
    system "./test"
  end
end
