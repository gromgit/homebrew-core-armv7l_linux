class Keystone < Formula
  desc "Assembler framework: Core + bindings"
  homepage "https://www.keystone-engine.org/"
  url "https://github.com/keystone-engine/keystone/archive/0.9.2.tar.gz"
  sha256 "c9b3a343ed3e05ee168d29daf89820aff9effb2c74c6803c2d9e21d55b5b7c24"
  license "GPL-2.0"
  head "https://github.com/keystone-engine/keystone.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/keystone"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "943b15cabb386491b48725b05e889457ab6dd74517feb8d2dadace7b5fdfab2d"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    assert_equal "nop = [ 90 ]", shell_output("#{bin}/kstool x16 nop").strip
  end
end
