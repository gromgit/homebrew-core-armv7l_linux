class Fping < Formula
  desc "Scriptable ping program for checking if multiple hosts are up"
  homepage "https://fping.org/"
  url "https://fping.org/dist/fping-5.1.tar.gz"
  sha256 "1ee5268c063d76646af2b4426052e7d81a42b657e6a77d8e7d3d2e60fd7409fe"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?fping[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fping"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e2ef23733cc882bc02b170a6e11bec3b05e3d85cfa7ad88c30f955d1f94f6ca4"
  end

  head do
    url "https://github.com/schweikert/fping.git", branch: "develop"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", *std_configure_args, "--sbindir=#{bin}"
    system "make", "install"
  end

  test do
    assert_match "Version #{version}", shell_output("#{bin}/fping --version")
    assert_match "Probing options:", shell_output("#{bin}/fping --help")
    if OS.mac?
      assert_equal "::1 is alive", shell_output("#{bin}/fping -A localhost").chomp
    else
      assert_match "can't create socket", shell_output("#{bin}/fping -A localhost 2>&1", 4)
    end
  end
end
