class Apib < Formula
  desc "HTTP performance-testing tool"
  homepage "https://github.com/apigee/apib"
  url "https://github.com/apigee/apib/archive/APIB_1_2_1.tar.gz"
  sha256 "e47f639aa6ffc14a2e5b03bf95e8b0edc390fa0bb2594a521f779d6e17afc14c"
  license "Apache-2.0"
  head "https://github.com/apigee/apib.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/apib"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "23fb98927aaa359cbdbed37da3db269b5409fe83bb9b50626a41b4960ce8f5fe"
  end

  depends_on "cmake" => :build
  depends_on "libev"
  depends_on "openssl@1.1"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "apib", "apibmon"

    bin.install "apib/apib", "apib/apibmon"
  end

  test do
    system "#{bin}/apib", "-c 1", "-d 1", "https://www.google.com"
  end
end
