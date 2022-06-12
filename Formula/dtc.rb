class Dtc < Formula
  desc "Device tree compiler"
  homepage "https://www.devicetree.org/"
  url "https://www.kernel.org/pub/software/utils/dtc/dtc-1.6.1.tar.xz"
  sha256 "65cec529893659a49a89740bb362f507a3b94fc8cd791e76a8d6a2b6f3203473"
  license any_of: ["GPL-2.0-or-later", "BSD-2-Clause"]

  livecheck do
    url "https://mirrors.edge.kernel.org/pub/software/utils/dtc/"
    regex(/href=.*?dtc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dtc"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "fcbbb73f5251ca912dcd2e2ed6ce10002a2202c36e03d5ce080bce525e0473ff"
  end

  depends_on "pkg-config" => :build

  uses_from_macos "bison"
  uses_from_macos "flex"

  def install
    inreplace "libfdt/Makefile.libfdt", "libfdt.$(SHAREDLIB_EXT).1", "libfdt.1.$(SHAREDLIB_EXT)"
    system "make", "NO_PYTHON=1"
    system "make", "NO_PYTHON=1", "DESTDIR=#{prefix}", "PREFIX=", "install"
  end

  test do
    (testpath/"test.dts").write <<~EOS
      /dts-v1/;
      / {
      };
    EOS
    system "#{bin}/dtc", "test.dts"
  end
end
