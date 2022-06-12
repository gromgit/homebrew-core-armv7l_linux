class Crm114 < Formula
  desc "Examine, sort, filter or alter logs or data streams"
  homepage "https://crm114.sourceforge.io/"
  url "https://crm114.sourceforge.io/tarballs/crm114-20100106-BlameMichelson.src.tar.gz"
  sha256 "fb626472eca43ac2bc03526d49151c5f76b46b92327ab9ee9c9455210b938c2b"

  livecheck do
    url "https://crm114.sourceforge.io/wiki/doku.php?id=download"
    regex(%r{href=.*?/crm114[._-]v?(\d+(?:\.\d+)*)[._-]([a-z]+)?\.src\.t}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/crm114"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "364c1b9978f9315aea6bdd0021ecdd78cab09453dd730e8c6d022cfbc4db7786"
  end

  depends_on "tre"

  def install
    ENV.append "CFLAGS", "-std=gnu89"
    inreplace "Makefile", "LDFLAGS += -static -static-libgcc", ""
    bin.mkpath
    system "make", "prefix=#{prefix}", "install"
  end
end
