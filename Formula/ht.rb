class Ht < Formula
  desc "Viewer/editor/analyzer for executables"
  homepage "https://hte.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/hte/ht-source/ht-2.1.0.tar.bz2"
  sha256 "31f5e8e2ca7f85d40bb18ef518bf1a105a6f602918a0755bc649f3f407b75d70"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ht"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "291eef4b5dabf87689e1c1bb7006c7f6ce08b77064c23da2da725f158a3de723"
  end

  depends_on "lzo"

  uses_from_macos "ncurses"

  def install
    # Fix compilation with Xcode 9
    # https://github.com/sebastianbiallas/ht/pull/18
    inreplace "htapp.cc", "(abs(a - b) > 1)", "(abs((int)a - (int)b))"

    chmod 0755, "./install-sh"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-x11-textmode"
    system "make", "install"
  end

  test do
    assert_match "ht #{version}", shell_output("#{bin}/ht -v")
  end
end
