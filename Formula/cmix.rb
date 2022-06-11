class Cmix < Formula
  desc "Data compression program with high compression ratio"
  homepage "https://www.byronknoll.com/cmix.html"
  url "https://github.com/byronknoll/cmix/archive/v18.tar.gz"
  version "18.0.0"
  sha256 "2f0272186a8ff693146d0d8070ad4d9687461a486805ab91d727891df316498d"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cmix"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c3bf0711fc46cdf8ae5baa2a6b4e3283b78caf5006c44471c66dc2cea02d5df9"
  end

  def install
    system "make"
    bin.install "cmix"
  end

  test do
    (testpath/"foo").write "test"
    system "#{bin}/cmix", "-c", "foo", "foo.cmix"
    system "#{bin}/cmix", "-d", "foo.cmix", "foo.unpacked"
    assert_equal "test", shell_output("cat foo.unpacked")
  end
end
