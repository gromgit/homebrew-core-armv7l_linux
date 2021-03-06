class Drafter < Formula
  desc "Native C/C++ API Blueprint Parser"
  homepage "https://apiblueprint.org/"
  url "https://github.com/apiaryio/drafter/releases/download/v5.0.0/drafter-5.0.0.tar.gz"
  sha256 "a35894a8f4de8b9ead216056b6a77c8c03a4156b6a6e7eae46d9e11d116a748e"
  license "MIT"
  head "https://github.com/apiaryio/drafter.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/drafter"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ff5047515a05fbd541410532decbbef94434ec5a23852a31de69a11759157c11"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "drafter"
    system "make", "install"
  end

  test do
    (testpath/"api.apib").write <<~EOS
      # Homebrew API [/brew]

      ## Retrieve All Formula [GET /Formula]
      + Response 200 (application/json)
        + Attributes (array)
    EOS
    assert_equal "OK.", shell_output("#{bin}/drafter -l api.apib 2>&1").strip
  end
end
