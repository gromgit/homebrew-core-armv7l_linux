class Gaffitter < Formula
  desc "Efficiently fit files/folders to fixed size volumes (like DVDs)"
  homepage "https://gaffitter.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/gaffitter/gaffitter/1.0.0/gaffitter-1.0.0.tar.gz"
  sha256 "c85d33bdc6c0875a7144b540a7cce3e78e7c23d2ead0489327625549c3ab23ee"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gaffitter"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "39dac08832c51ab6f2a7aa3ab53799939f38b65abe3983e49aa89452d8daa333"
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system bin/"fit", "-t", "10m", "--show-size", testpath
  end
end
