class Fex < Formula
  desc "Powerful field extraction tool"
  homepage "https://www.semicomplete.com/projects/fex/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/semicomplete/fex-2.0.0.tar.gz"
  sha256 "03043c8eac74f43173068a2e693b6f73d5b45f453a063e6da11f34455d0e374e"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fex"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "16775a6c3843ca72684d9617c2143884e318131198aba495089f82050495ddc0"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_equal "foo", pipe_output("#{bin}/fex 1", "foo bar", 0).chomp
  end
end
