class Mktorrent < Formula
  desc "Create BitTorrent metainfo files"
  homepage "https://github.com/pobrn/mktorrent/wiki"
  url "https://github.com/pobrn/mktorrent/archive/v1.1.tar.gz"
  sha256 "d0f47500192605d01b5a2569c605e51ed319f557d24cfcbcb23a26d51d6138c9"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mktorrent"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c1c4b2fbcb246304a29d3d0075a6265503eb38e718aec975f4c8eadcb0117c9b"
  end

  depends_on "openssl@1.1"

  def install
    system "make", "USE_PTHREADS=1", "USE_OPENSSL=1", "USE_LONG_OPTIONS=1"
    bin.install "mktorrent"
  end

  test do
    (testpath/"test.txt").write <<~EOS
      Injustice anywhere is a threat to justice everywhere.
    EOS

    system bin/"mktorrent", "-d", "-c", "Martin Luther King Jr", "test.txt"
    assert_predicate testpath/"test.txt.torrent", :exist?, "Torrent was not created"

    file = File.read(testpath/"test.txt.torrent")
    output = file.force_encoding("ASCII-8BIT") if file.respond_to?(:force_encoding)
    assert_match "Martin Luther King Jr", output
  end
end
