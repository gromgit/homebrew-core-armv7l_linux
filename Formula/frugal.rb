class Frugal < Formula
  desc "Cross language code generator for creating scalable microservices"
  homepage "https://github.com/Workiva/frugal"
  url "https://github.com/Workiva/frugal/archive/v3.15.1.tar.gz"
  sha256 "ea7a16da061082d2016ec058835ec7e7e42f42cd6f3fa94fb455be8157f9ddf6"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/frugal"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "54e2a4b7bb7bf1c80fb2d143ccc9b7bbaf2f592299feafa123debc83e1bd4c3c"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    (testpath/"test.frugal").write("typedef double Test")
    system "#{bin}/frugal", "--gen", "go", "test.frugal"
    assert_match "type Test float64", (testpath/"gen-go/test/f_types.go").read
  end
end
