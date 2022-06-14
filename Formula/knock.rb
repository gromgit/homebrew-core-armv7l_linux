class Knock < Formula
  desc "Port-knock server"
  homepage "https://zeroflux.org/projects/knock"
  url "https://zeroflux.org/proj/knock/files/knock-0.8.tar.gz"
  sha256 "698d8c965624ea2ecb1e3df4524ed05afe387f6d20ded1e8a231209ad48169c7"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.zeroflux.org/projects/knock"
    regex(%r{The current version of knockd is <strong>v?(\d+(?:\.\d+)+)</strong>}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/knock"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "4d2317ef8b9438f05b6a92877ea6e4c761e7c913419bbe388fca03396f189a96"
  end

  head do
    url "https://github.com/jvinet/knock.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  uses_from_macos "libpcap"

  def install
    system "autoreconf", "-fi" if build.head?
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/knock", "localhost", "123:tcp"
  end
end
