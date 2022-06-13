class Geographiclib < Formula
  desc "C++ geography library"
  homepage "https://geographiclib.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/geographiclib/distrib-C++/GeographicLib-2.0.tar.gz"
  sha256 "906b862aa9e988534fd5b8d9f3bae07437e0079a4236e19942ab61fe8c83960b"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/geographiclib"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "187eb1e2f97154da8acc086385e6afff835e652eba1692a02b5535c37096209c"
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-DCMAKE_OSX_SYSROOT=#{MacOS.sdk_path}" if OS.mac?
      args << "-DEXAMPLEDIR="
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    system bin/"GeoConvert", "-p", "-3", "-m", "--input-string", "33.3 44.4"
  end
end
