class Box2d < Formula
  desc "2D physics engine for games"
  homepage "https://box2d.org"
  url "https://github.com/erincatto/box2d/archive/v2.4.1.tar.gz"
  sha256 "d6b4650ff897ee1ead27cf77a5933ea197cbeef6705638dd181adc2e816b23c2"
  license "MIT"
  head "https://github.com/erincatto/Box2D.git", branch: "main"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/box2d"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c18b19c325b7946eb2c90e5151a0c52045239d239e10ebe8cc13d8d41420d3f8"
  end

  depends_on "cmake" => :build

  def install
    args = std_cmake_args + %w[
      -DBOX2D_BUILD_UNIT_TESTS=OFF
      -DBOX2D_BUILD_TESTBED=OFF
      -DBOX2D_BUILD_EXAMPLES=OFF
    ]

    system "cmake", ".", *args
    system "cmake", "--build", "."
    system "cmake", "--install", "."
    pkgshare.install "unit-test/hello_world.cpp", "unit-test/doctest.h"
  end

  test do
    system ENV.cxx, pkgshare/"hello_world.cpp", "-L#{lib}", "-lbox2d",
      "-std=c++11", "-o", testpath/"test"
    assert_match "[doctest] Status: SUCCESS!", shell_output("./test")
  end
end
