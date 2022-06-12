class Dfc < Formula
  desc "Display graphs and colors of file system space/usage"
  homepage "https://github.com/Rolinh/dfc"
  url "https://github.com/Rolinh/dfc/releases/download/v3.1.1/dfc-3.1.1.tar.gz"
  sha256 "962466e77407dd5be715a41ffc50a54fce758a78831546f03a6bb282e8692e54"
  license "BSD-3-Clause"
  revision 1
  head "https://github.com/Rolinh/dfc.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dfc"
    sha256 armv7l_linux: "f6907d1192519a2e37358829ae1096663731c8f2c6d35570d4583e70a9c7838f"
  end

  depends_on "cmake" => :build
  depends_on "gettext"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system bin/"dfc", "-T"
    assert_match ",%USED,", shell_output("#{bin}/dfc -e csv")
  end
end
