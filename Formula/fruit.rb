class Fruit < Formula
  desc "Dependency injection framework for C++"
  homepage "https://github.com/google/fruit/wiki"
  url "https://github.com/google/fruit/archive/v3.6.0.tar.gz"
  sha256 "b35b9380f3affe0b3326f387505fa80f3584b0d0a270362df1f4ca9c39094eb5"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fruit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8e85748f34a8e132331c50e845a90da2ed64907e5f08ba0029a835b45540bda6"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DFRUIT_USES_BOOST=False", *std_cmake_args
    system "make", "install"
    pkgshare.install "examples/hello_world/main.cpp"
  end

  test do
    cp_r pkgshare/"main.cpp", testpath
    system ENV.cxx, "main.cpp", "-I#{include}", "-L#{lib}",
           "-std=c++11", "-lfruit", "-o", "test"
    system "./test"
  end
end
