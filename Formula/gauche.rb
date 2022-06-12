class Gauche < Formula
  desc "R7RS Scheme implementation, developed to be a handy script interpreter"
  homepage "https://practical-scheme.net/gauche/"
  url "https://github.com/shirok/Gauche/releases/download/release0_9_11_p1/Gauche-0.9.11-p1.tgz"
  sha256 "9069c347e12e7fd14072680100e63dedec92de8fd7f48a200224b4d478733795"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
    regex(/href=.*?Gauche[._-]v?(\d+(?:\.\d+)+(?:[._-]p\d+)?)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gauche"
    sha256 armv7l_linux: "591da437ad4ed9df19758854b4d8d689301f7589d13aa7765fd4080271b47a2b"
  end

  depends_on "mbedtls"

  uses_from_macos "zlib"

  def install
    system "./configure", *std_configure_args,
                          "--enable-multibyte=utf-8"
    system "make"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/gosh -V")
    assert_match "Gauche scheme shell, version #{version}", output
  end
end
