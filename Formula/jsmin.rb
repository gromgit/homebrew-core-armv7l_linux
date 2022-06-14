class Jsmin < Formula
  desc "Minify JavaScript code"
  homepage "https://www.crockford.com/javascript/jsmin.html"
  url "https://github.com/douglascrockford/JSMin/archive/430bfe68dc0823d8c0f92c08d426e517cbc8de5e.tar.gz"
  version "2019-10-30"
  sha256 "24e3ad04979ace5d734e38b843f62f0dc832f94f5ba48642da31b4a33ccec9ac"
  license "JSON"

  # The GitHub repository doesn't contain any tags, so we have to check the
  # date in the comment at the top of the `jsmin.c` file.
  livecheck do
    url "https://raw.githubusercontent.com/douglascrockford/JSMin/master/jsmin.c"
    regex(/jsmin\.c\s*(\d{4}-\d{1,2}-\d{1,2})/im)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jsmin"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "878644777d0401b9cef612148599d915d4b7d4800b6f96054682e4312d0b2d00"
  end

  def install
    system ENV.cc, "jsmin.c", "-o", "jsmin"
    bin.install "jsmin"
  end

  test do
    assert_equal "\nvar i=0;", pipe_output(bin/"jsmin", "var i = 0; // comment")
  end
end
