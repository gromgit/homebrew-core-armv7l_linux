class Lha < Formula
  desc "Utility for creating and opening lzh archives"
  homepage "https://lha.osdn.jp/"
  # Canonical: https://osdn.net/dl/lha/lha-1.14i-ac20050924p1.tar.gz
  url "https://dotsrc.dl.osdn.net/osdn/lha/22231/lha-1.14i-ac20050924p1.tar.gz"
  version "1.14i-ac20050924p1"
  sha256 "b5261e9f98538816aa9e64791f23cb83f1632ecda61f02e54b6749e9ca5e9ee4"
  license "MIT"

  # OSDN releases pages use asynchronous requests to fetch the archive
  # information for each release, rather than including this information in the
  # page source. As such, we identify versions from the release names instead.
  # The portion of the regex that captures the version is looser than usual
  # because the version format is unusual and may change in the future.
  livecheck do
    url "https://osdn.net/projects/lha/releases/"
    regex(%r{href=.*?/projects/lha/releases/[^>]+?>\s*?v?(\d+(?:[.-][\da-z]+)+)}im)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/lha"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7a44d34ad3bce2824d2b7b3f1dea3eac13b64c750c8a5446ab3fb84f34b99fbd"
  end

  head do
    url "https://github.com/jca02266/lha.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  conflicts_with "lhasa", because: "both install a `lha` binary"

  def install
    # Work around configure/build issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    system "autoreconf", "-is" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    (testpath/"foo").write "test"
    system "#{bin}/lha", "c", "foo.lzh", "foo"
    assert_equal "::::::::\nfoo\n::::::::\ntest",
      shell_output("#{bin}/lha p foo.lzh")
  end
end
