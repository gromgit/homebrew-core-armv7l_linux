class Packetq < Formula
  desc "SQL-like frontend to PCAP files"
  homepage "https://www.dns-oarc.net/tools/packetq"
  url "https://www.dns-oarc.net/files/packetq/packetq-1.7.1.tar.gz"
  sha256 "a1b087335fcb018a5ded3d067d22ee906d24b6e932f018e959302be9b527c620"
  license "GPL-3.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?packetq[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/packetq"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "31a877bd466c0eb1eb2f8464e3a3ecbcaaddb90bc3a2e8619e6af8c868a47c7a"
  end

  uses_from_macos "zlib"

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/packetq --csv -s 'select id from dns' -")
    assert_equal '"id"', output.chomp
  end
end
