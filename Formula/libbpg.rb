class Libbpg < Formula
  desc "Image format meant to improve on JPEG quality and file size"
  homepage "https://bellard.org/bpg/"
  url "https://bellard.org/bpg/libbpg-0.9.8.tar.gz"
  sha256 "c0788e23bdf1a7d36cb4424ccb2fae4c7789ac94949563c4ad0e2569d3bf0095"

  livecheck do
    url :homepage
    regex(/href=.*?libbpg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libbpg"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8317dd78ee370b7f10b1641707b17a78eac68b98c70d556d8c74f27d9d691cba"
  end

  depends_on "cmake" => :build
  depends_on "yasm" => :build
  depends_on "jpeg"
  depends_on "libpng"

  def install
    bin.mkpath
    extra_args = []
    extra_args << "CONFIG_APPLE=y" if OS.mac?
    system "make", "install", "prefix=#{prefix}", *extra_args
    pkgshare.install Dir["html/bpgdec*.js"]
  end

  test do
    system "#{bin}/bpgenc", test_fixtures("test.png")
    assert_predicate testpath/"out.bpg", :exist?
  end
end
