class Multimarkdown < Formula
  desc "Turn marked-up plain text into well-formatted documents"
  homepage "https://fletcher.github.io/MultiMarkdown-6/"
  url "https://github.com/fletcher/MultiMarkdown-6/archive/6.6.0.tar.gz"
  sha256 "6496b43c933d2f93ff6be80f5029d37e9576a5d5eacb90900e6b28c90405037f"
  license "MIT"
  head "https://github.com/fletcher/MultiMarkdown-6.git", branch: "develop"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/multimarkdown"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "076d7efd01fec5bb9b5d39b8f1adca866c9c5aa6773a6648b4b149c291cf991d"
  end

  depends_on "cmake" => :build

  conflicts_with "mtools", because: "both install `mmd` binaries"
  conflicts_with "markdown", because: "both install `markdown` binaries"
  conflicts_with "discount", because: "both install `markdown` binaries"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      bin.install "multimarkdown"
    end

    bin.install Dir["scripts/*"].reject { |f| f.end_with?(".bat") }
  end

  test do
    assert_equal "<p>foo <em>bar</em></p>\n", pipe_output(bin/"multimarkdown", "foo *bar*\n")
    assert_equal "<p>foo <em>bar</em></p>\n", pipe_output(bin/"mmd", "foo *bar*\n")
  end
end
