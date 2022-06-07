class Fx < Formula
  desc "Terminal JSON viewer"
  homepage "https://fx.wtf"
  url "https://github.com/antonmedv/fx/archive/refs/tags/24.0.0.tar.gz"
  sha256 "43682e6b189a84602930b9fb09a87af400359a9e97a4bb8e1119688c53fad9fd"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fx"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7e085cbbd908408c8ad022368d70aa3c1fa95d87e54dc8003a614759dd398317"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_equal "42", pipe_output(bin/"fx", 42).strip
  end
end
