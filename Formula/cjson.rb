class Cjson < Formula
  desc "Ultralightweight JSON parser in ANSI C"
  homepage "https://github.com/DaveGamble/cJSON"
  url "https://github.com/DaveGamble/cJSON/archive/v1.7.15.tar.gz"
  sha256 "5308fd4bd90cef7aa060558514de6a1a4a0819974a26e6ed13973c5f624c24b2"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cjson"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1a8050be1c8c65a4754ba3c7daf8381d1bc517ea8f5ede911b5877309259814f"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-DENABLE_CJSON_UTILS=On", "-DENABLE_CJSON_TEST=Off",
                    "-DBUILD_SHARED_AND_STATIC_LIBS=On", ".",
                    *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <cjson/cJSON.h>

      int main()
      {
        char *s = "{\\"key\\":\\"value\\"}";
        cJSON *json = cJSON_Parse(s);
        if (!json) {
            return 1;
        }
        cJSON *item = cJSON_GetObjectItem(json, "key");
        if (!item) {
            return 1;
        }
        cJSON_Delete(json);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lcjson", "-o", "test"
    system "./test"
  end
end
