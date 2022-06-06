class Avce00 < Formula
  desc "Make Arc/Info (binary) Vector Coverages appear as E00"
  homepage "http://avce00.maptools.org/avce00/index.html"
  url "http://avce00.maptools.org/dl/avce00-2.0.0.tar.gz"
  sha256 "c0851f86b4cd414d6150a04820491024fb6248b52ca5c7bd1ca3d2a0f9946a40"

  livecheck do
    url :homepage
    regex(/href=.*?avce00[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/avce00"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f7acfc1ac291d4881a90cd1f8753760c03f99acc428b5dc0dc1d50a6600bd4fe"
  end

  conflicts_with "gdal", because: "both install a cpl_conv.h header"

  def install
    system "make", "CC=#{ENV.cc}"
    bin.install "avcimport", "avcexport", "avcdelete", "avctest"
    lib.install "avc.a"
    include.install Dir["*.h"]
  end

  test do
    touch testpath/"test"
    system "#{bin}/avctest", "-b", "test"
  end
end
