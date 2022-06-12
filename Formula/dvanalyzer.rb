class Dvanalyzer < Formula
  desc "Quality control tool for examining tape-to-file DV streams"
  homepage "https://mediaarea.net/DVAnalyzer"
  url "https://mediaarea.net/download/binary/dvanalyzer/1.4.2/DVAnalyzer_CLI_1.4.2_GNU_FromSource.tar.bz2"
  sha256 "d2f3fdd98574f7db648708e1e46b0e2fa5f9e6e12ca14d2dfaa77c13c165914c"

  livecheck do
    url "https://mediaarea.net/DVAnalyzer/Download/Source"
    regex(/href=.*?dvanalyzer[._-]?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dvanalyzer"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1c88240068a3fca5a6d0824d5445609c2558327e6c5fdae92499dca211f22746"
  end

  uses_from_macos "zlib"

  def install
    cd "ZenLib/Project/GNU/Library" do
      args = ["--disable-debug",
              "--enable-static",
              "--disable-shared"]
      system "./configure", *args
      system "make"
    end

    cd "MediaInfoLib/Project/GNU/Library" do
      args = ["--disable-debug",
              "--enable-static",
              "--disable-shared"]
      system "./configure", *args
      system "make"
    end

    cd "AVPS_DV_Analyzer/Project/GNU/CLI" do
      system "./configure",  "--disable-debug", "--enable-staticlibs", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    pipe_output("#{bin}/dvanalyzer --Header", test_fixtures("test.mp3"))
  end
end
