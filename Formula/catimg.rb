class Catimg < Formula
  desc "Insanely fast image printing in your terminal"
  homepage "https://github.com/posva/catimg"
  url "https://github.com/posva/catimg/archive/2.7.0.tar.gz"
  sha256 "3a6450316ff62fb07c3facb47ea208bf98f62abd02783e88c56f2a6508035139"
  license "MIT"
  head "https://github.com/posva/catimg.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/catimg"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d98e4646677b1917c966d98f7602d369c4bc485c678a8b595eae7c672b364be2"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-DMAN_OUTPUT_PATH=#{man1}", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/catimg", test_fixtures("test.png")
  end
end
