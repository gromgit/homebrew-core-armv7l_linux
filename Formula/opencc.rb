class Opencc < Formula
  desc "Simplified-traditional Chinese conversion tool"
  homepage "https://github.com/BYVoid/OpenCC"
  url "https://github.com/BYVoid/OpenCC/archive/ver.1.1.3.tar.gz"
  sha256 "99a9af883b304f11f3b0f6df30d9fb4161f15b848803f9ff9c65a96d59ce877f"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/opencc"
    sha256 armv7l_linux: "d218ee6912423898386bd102822e68dbbd8b28fcd4d6b6a74a8935708bc77a46"
  end

  depends_on "cmake" => :build

  def install
    ENV.cxx11
    mkdir "build" do
      system "cmake", "..", "-DBUILD_DOCUMENTATION:BOOL=OFF", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
      system "make"
      system "make", "install"
    end
  end

  test do
    input = "中国鼠标软件打印机"
    output = pipe_output("#{bin}/opencc", input)
    output = output.force_encoding("UTF-8") if output.respond_to?(:force_encoding)
    assert_match "中國鼠標軟件打印機", output
  end
end
