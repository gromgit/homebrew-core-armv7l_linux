class Httperf < Formula
  desc "Tool for measuring webserver performance"
  homepage "https://github.com/httperf/httperf"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/httperf/httperf-0.9.0.tar.gz"
  sha256 "e1a0bf56bcb746c04674c47b6cfa531fad24e45e9c6de02aea0d1c5f85a2bf1c"
  license "GPL-2.0"
  revision 2

  # Until the upstream GitHub repository creates a new release (something after
  # 0.9.0), we're unable to create a check that can identify new versions.
  livecheck do
    skip "No version information available to check"
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/httperf"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "6ff3a9e1f651bbdd438b5488ee1a7d85bcf027e2494d00116db26b869f01fd13"
  end

  head do
    url "https://github.com/httperf/httperf.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "openssl@1.1"

  # Upstream patch for OpenSSL 1.1 compatibility
  # https://github.com/httperf/httperf/pull/48
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/85fa66a9/httperf/openssl-1.1.diff"
    sha256 "69d5003f60f5e46d25813775bbf861366fb751da4e0e4d2fe7530d7bb3f3660a"
  end

  def install
    system "autoreconf", "-fvi" if build.head?
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system "#{bin}/httperf", "--version"
  end
end
