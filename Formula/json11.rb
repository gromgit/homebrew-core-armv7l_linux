class Json11 < Formula
  desc "Tiny JSON library for C++11"
  homepage "https://github.com/dropbox/json11"
  url "https://github.com/dropbox/json11/archive/v1.0.0.tar.gz"
  sha256 "bab960eebc084d26aaf117b8b8809aecec1e86e371a173655b7dffb49383b0bf"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/json11"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "5e98a42948a7195110ff76ec3f1f406b05bab92a36e429b5b5cec0e0a73f0fbc"
  end

  deprecate! date: "2020-03-25", because: :repo_archived

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <json11.hpp>
      #include <string>
      using namespace json11;

      int main() {
        Json my_json = Json::object {
          { "key1", "value1" },
          { "key2", false },
          { "key3", Json::array { 1, 2, 3 } },
        };
        auto json_str = my_json.dump();
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-I#{include}", "-L#{lib}",
                    "-ljson11", "-o", "test"
    system "./test"
  end
end
