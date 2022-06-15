class Ngrep < Formula
  desc "Network grep"
  homepage "https://github.com/jpr5/ngrep"
  url "https://github.com/jpr5/ngrep/archive/V1_47.tar.gz"
  sha256 "dc4dbe20991cc36bac5e97e99475e2a1522fd88c59ee2e08f813432c04c5fff3"
  license :cannot_represent # Described as 'BSD with advertising' here: https://src.fedoraproject.org/rpms/ngrep/blob/rawhide/f/ngrep.spec#_8

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ngrep"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a3239a4a6e688e2acee57cfb3e8f0773d072e9d8b6a2f55a1fb65f3560f5a8ce"
  end

  uses_from_macos "libpcap"

  def install
    sdk = MacOS.sdk_path_if_needed ? MacOS.sdk_path : ""

    args = [
      "--enable-ipv6",
      "--prefix=#{prefix}",
      # this line required to avoid segfaults
      # see https://github.com/jpr5/ngrep/commit/e29fc29
      # https://github.com/Homebrew/homebrew/issues/27171
      "--disable-pcap-restart",
    ]

    args << if OS.mac?
      # this line required to make configure succeed
      "--with-pcap-includes=#{sdk}/usr/include/pcap"
    else
      # this line required to make configure succeed
      "--with-pcap-includes=#{Formula["libpcap"].opt_include}/pcap"
    end

    system "./configure", *args

    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ngrep -V")
  end
end
