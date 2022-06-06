class Bwfmetaedit < Formula
  desc "Tool for embedding, validating, and exporting BWF file metadata"
  homepage "https://mediaarea.net/BWFMetaEdit"
  url "https://mediaarea.net/download/binary/bwfmetaedit/21.07/BWFMetaEdit_CLI_21.07_GNU_FromSource.tar.bz2"
  sha256 "7b55d9c6df989a3cbff2bb2c9a18b0b0f3a80fa716539a160d612194906d94f2"
  license "0BSD"

  livecheck do
    url "https://mediaarea.net/BWFMetaEdit/Download/Source"
    regex(/href=.*?bwfmetaedit[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bwfmetaedit"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "167678b525bbdeb1ff03fe9ee3e0bf95076497d5527f143202b4376f629a386c"
  end

  def install
    cd "Project/GNU/CLI" do
      system "./configure",  "--disable-debug", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    pipe_output("#{bin}/bwfmetaedit --out-tech", test_fixtures("test.wav"))
  end
end
