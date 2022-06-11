class Aview < Formula
  desc "ASCII-art image browser and animation viewer"
  homepage "https://aa-project.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/aa-project/aview/1.3.0rc1/aview-1.3.0rc1.tar.gz"
  sha256 "42d61c4194e8b9b69a881fdde698c83cb27d7eda59e08b300e73aaa34474ec99"
  license "GPL-2.0"

  livecheck do
    url :stable
    regex(%r{url=.*?/aview[._-]v?(\d+(?:\.\d+)+(?:[a-z]+\d*)?)\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/aview"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d8ed4f96be60ee22e4d299f5245d6616c1e5856320593ff78b75a88812d6edad"
  end

  depends_on "aalib"

  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/85fa66a9/aview/1.3.0rc1.patch"
    sha256 "72a979eff325056f709cee49f5836a425635bd72078515a5949a812aa68741aa"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/aview", "--version"
  end
end
