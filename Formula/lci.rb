class Lci < Formula
  desc "Interpreter for the lambda calculus"
  homepage "https://www.chatzi.org/lci/"
  url "https://github.com/chatziko/lci/releases/download/v1.0/lci-1.0.tar.gz"
  sha256 "1bcf40d738ce2af7ca5116f02dfb0f4ed21d7e467e3618e071c8199a1285331e"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/lci"
    rebuild 1
    sha256 armv7l_linux: "6d7578f0f7868cc3c577b94800d2c0cb017218b252c262136c5ae91270460ba0"
  end

  depends_on "cmake" => :build

  conflicts_with "lolcode", because: "both install `lci` binaries"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    assert_match "[I, 2]", pipe_output("#{bin}/lci", "Append [1] [2]\n")
  end
end
