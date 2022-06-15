class Mkcue < Formula
  desc "Generate a CUE sheet from a CD"
  homepage "https://packages.debian.org/sid/mkcue"
  url "https://deb.debian.org/debian/pool/main/m/mkcue/mkcue_1.orig.tar.gz"
  version "1"
  sha256 "2aaf57da4d0f2e24329d5e952e90ec182d4aa82e4b2e025283e42370f9494867"
  license "LGPL-2.1"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mkcue"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "49de0d0716836cf4d7071e4dd1798da2dd4cf726e53865dfc02ad96755c7a3fe"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    bin.mkpath
    system "make", "install"
  end

  test do
    touch testpath/"test"
    system "#{bin}/mkcue", "test" unless ENV["HOMEBREW_GITHUB_ACTIONS"]

    if ENV["HOMEBREW_GITHUB_ACTIONS"]
      on_macos do
        system "#{bin}/mkcue", "test"
      end
      on_linux do
        assert_match "Cannot read table of contents", shell_output("#{bin}/mkcue test 2>&1", 2)
      end
    end
  end
end
