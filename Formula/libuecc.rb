class Libuecc < Formula
  desc "Very small Elliptic Curve Cryptography library"
  homepage "https://git.universe-factory.net/libuecc/"
  url "https://git.universe-factory.net/libuecc/snapshot/libuecc-7.tar"
  sha256 "0120aee869f56289204255ba81535369816655264dd018c63969bf35b71fd707"
  head "https://git.universe-factory.net/libuecc", using: :git, branch: "master"

  livecheck do
    url :head
    regex(/href=.*?libuecc[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libuecc"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d90e30659aafd72e323130338e9deb8fc72a475aacd3a8c2cef423c962c0fbbf"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdlib.h>
      #include <libuecc/ecc.h>

      int main(void)
      {
          ecc_int256_t secret;
          ecc_25519_gf_sanitize_secret(&secret, &secret);

          return EXIT_SUCCESS;
      }
    EOS
    system ENV.cc, "-I#{include}/libuecc-#{version}", "-L#{lib}", "-o", "test", "test.c", "-luecc"
    system "./test"
  end
end
