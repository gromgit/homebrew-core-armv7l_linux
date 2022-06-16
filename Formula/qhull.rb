class Qhull < Formula
  desc "Computes convex hulls in n dimensions"
  homepage "http://www.qhull.org/"
  url "http://www.qhull.org/download/qhull-2020-src-8.0.2.tgz"
  version "2020.2"
  sha256 "b5c2d7eb833278881b952c8a52d20179eab87766b00b865000469a45c1838b7e"
  license "Qhull"
  head "https://github.com/qhull/qhull.git", branch: "master"

  # It's necessary to match the version from the link text, as the filename
  # only contains the year (`2020`), not a full version like `2020.2`.
  livecheck do
    url "http://www.qhull.org/download/"
    regex(/href=.*?qhull[._-][^"' >]+?[._-]src[^>]*?\.t[^>]+?>[^<]*Qhull v?(\d+(?:\.\d+)*)/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/qhull"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "230c96f3d07949b4d3e700a0b108791b621b7e53d3a17e96186f8291b7cd0ed4"
  end

  depends_on "cmake" => :build

  def install
    ENV.cxx11

    cd "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    input = shell_output(bin/"rbox c D2")
    output = pipe_output("#{bin}/qconvex s n 2>&1", input, 0)
    assert_match "Number of facets: 4", output
  end
end
