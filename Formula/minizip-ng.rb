class MinizipNg < Formula
  desc "Zip file manipulation library with minizip 1.x compatibility layer"
  homepage "https://github.com/zlib-ng/minizip-ng"
  url "https://github.com/zlib-ng/minizip-ng/archive/3.0.6.tar.gz"
  sha256 "383fa1bdc28c482828a8a8db53f758dbd44291b641182724fda5df5b59cce543"
  license "Zlib"
  head "https://github.com/zlib-ng/minizip-ng.git", branch: "dev"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/minizip-ng"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "2b5152f4aa714e7c4e11f84527e6f09d6005482f71dd5dd948de9811723cf4f2"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "xz"
  depends_on "zstd"

  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  on_linux do
    depends_on "openssl@1.1"
  end

  conflicts_with "minizip",
    because: "both install a `libminizip.a` library"
  conflicts_with "libtcod", "libzip",
    because: "libtcod, libzip and minizip-ng install a `zip.h` header"

  def install
    system "cmake", "-S", ".", "-B", "build/static",
                    "-DMZ_FETCH_LIBS=OFF",
                    *std_cmake_args
    system "cmake", "--build", "build/static"
    system "cmake", "--install", "build/static"

    system "cmake", "-S", ".", "-B", "build/shared",
                    "-DMZ_FETCH_LIBS=OFF",
                    "-DBUILD_SHARED_LIBS=ON",
                    *std_cmake_args
    system "cmake", "--build", "build/shared"
    system "cmake", "--install", "build/shared"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdlib.h>
      #include <stdint.h>
      #include <time.h>
      #include "mz_zip.h"
      #include "mz_compat.h"
      int main(void)
      {
        zipFile hZip = zipOpen2_64("test.zip", APPEND_STATUS_CREATE, NULL, NULL);
        return hZip != NULL && mz_zip_close(NULL) == MZ_PARAM_ERROR ? 0 : 1;
      }
    EOS

    lib_flags = if OS.mac?
      %W[
        -lz -lbz2 -liconv -lcompression
        -L#{Formula["zstd"].opt_lib} -lzstd
        -L#{Formula["xz"].opt_lib} -llzma
        -framework CoreFoundation -framework Security
      ]
    else
      %W[
        -L#{Formula["zlib"].opt_lib} -lz
        -L#{Formula["bzip2"].opt_lib} -lbz2
        -L#{Formula["zstd"].opt_lib} -lzstd
        -L#{Formula["xz"].opt_lib} -llzma
      ]
    end

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}",
                   "-lminizip", *lib_flags, "-o", "test"
    system "./test"
  end
end
