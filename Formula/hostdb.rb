class Hostdb < Formula
  desc "Generate DNS zones and DHCP configuration from hostlist.txt"
  homepage "https://code.google.com/archive/p/hostdb/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/hostdb/hostdb-1.004.tgz"
  sha256 "beea7cfcdc384eb40d0bc8b3ad2eb094ee81ca75e8eef7c07ea4a47e9f0da350"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/hostdb"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d1c397eae6bba51e1082904159e462f7cede76d7c3d1def04a0cfbc65cec17d5"
  end

  def install
    bin.install Dir["bin/*"]
    doc.install Dir["docs/*"]
    pkgshare.install "examples"
  end

  test do
    system("#{bin}/mkzones -z #{pkgshare}/examples/example1/zoneconf.txt < #{pkgshare}/examples/example1/hostdb.txt")
    expected = /^4 \s+ IN \s+ PTR \s+ vector\.example\.com\.$/x
    assert_match(expected, (testpath/"INTERNAL.179.32.64.in-addr.arpa").read)
  end
end
