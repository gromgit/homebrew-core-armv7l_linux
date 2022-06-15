class OrocosKdl < Formula
  desc "Orocos Kinematics and Dynamics C++ library"
  homepage "https://orocos.org/"
  url "https://github.com/orocos/orocos_kinematics_dynamics/archive/v1.5.1.tar.gz"
  sha256 "5acb90acd82b10971717aca6c17874390762ecdaa3a8e4db04984ea1d4a2af9b"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/orocos-kdl"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "bb49fe6a1e96b99743a41de886228fb7c0eb8e24c4ab2e2896e812ac119dd668"
  end

  depends_on "cmake" => :build
  depends_on "eigen"

  def install
    cd "orocos_kdl" do
      system "cmake", ".", "-DEIGEN3_INCLUDE_DIR=#{Formula["eigen"].opt_include}/eigen3",
                           *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <kdl/frames.hpp>
      int main()
      {
        using namespace KDL;
        Vector v1(1.,0.,1.);
        Vector v2(1.,0.,1.);
        assert(v1==v2);
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lorocos-kdl",
                    "-o", "test"
    system "./test"
  end
end
