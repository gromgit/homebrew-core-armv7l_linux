class Minica < Formula
  desc "Small, simple certificate authority"
  homepage "https://github.com/jsha/minica"
  url "https://github.com/jsha/minica/archive/v1.0.2.tar.gz"
  sha256 "c5b7e6c890ad472eb39f7e44d777da1b623930fd099b414213ced14bb599c6ec"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/minica"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8e585a5cb0504d6f8995f6c2f831595f9a82dae8bb72c77041a6499ab50df1da"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"minica"
  end

  test do
    system "#{bin}/minica", "--domains", "foo.com"
    assert_predicate testpath/"minica.pem", :exist?
  end
end
