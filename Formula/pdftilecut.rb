class Pdftilecut < Formula
  desc "Sub-divide a PDF page(s) into smaller pages so you can print them"
  homepage "https://github.com/oxplot/pdftilecut"
  url "https://github.com/oxplot/pdftilecut/archive/v0.5.tar.gz"
  sha256 "48a34df2ab7a9fbf2f7dbec328fae9cd15fff8a77fe938675a9e2ee336357b58"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pdftilecut"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c4db8e25ffb8718a43c4ad7982612ac0360f09199a0c6431813c3009347e52c4"
  end

  depends_on "go" => :build
  depends_on "jpeg-turbo"
  depends_on "qpdf"

  def install
    system "go", "build", *std_go_args
  end

  test do
    testpdf = test_fixtures("test.pdf")
    system "#{bin}/pdftilecut", "-tile-size", "A6", "-in", testpdf, "-out", "split.pdf"
    assert_predicate testpath/"split.pdf", :exist?, "Failed to create split.pdf"
  end
end
