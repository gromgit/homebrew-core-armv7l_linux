class OpentracingCpp < Formula
  desc "OpenTracing API for C++"
  homepage "https://opentracing.io/"
  url "https://github.com/opentracing/opentracing-cpp/archive/v1.6.0.tar.gz"
  sha256 "5b170042da4d1c4c231df6594da120875429d5231e9baa5179822ee8d1054ac3"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/opentracing-cpp"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "848b3e8a82981c2632d187b55d075cddf7c1ea6ed65f11fd68f83981526228dc"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
    system "make", "install"
    pkgshare.install "example/tutorial/tutorial-example.cpp"
    pkgshare.install "example/tutorial/text_map_carrier.h"
  end

  test do
    system ENV.cxx, "#{pkgshare}/tutorial-example.cpp", "-std=c++11", "-L#{lib}", "-I#{include}",
                    "-lopentracing", "-lopentracing_mocktracer", "-o", "tutorial-example"
    system "./tutorial-example"
  end
end
