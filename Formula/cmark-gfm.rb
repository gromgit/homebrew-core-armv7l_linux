class CmarkGfm < Formula
  desc "C implementation of GitHub Flavored Markdown"
  homepage "https://github.com/github/cmark-gfm"
  url "https://github.com/github/cmark-gfm/archive/0.29.0.gfm.4.tar.gz"
  version "0.29.0.gfm.4"
  sha256 "1be0d2c703b87cfbf51f91336db04039756e118c39398a392b9a3cca1b7d4ead"
  license "BSD-2-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cmark-gfm"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7bbdfe0df83b7eb2c04cb15f9fb7b44b221bfa0bd3e658b1796d6433742838ba"
  end

  depends_on "cmake" => :build
  depends_on "python@3.10" => :build

  conflicts_with "cmark", because: "both install a `cmark.h` header"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
      system "make", "install"
    end
  end

  test do
    output = pipe_output("#{bin}/cmark-gfm --extension autolink", "https://brew.sh")
    assert_equal '<p><a href="https://brew.sh">https://brew.sh</a></p>', output.chomp
  end
end
