class Cproto < Formula
  desc "Generate function prototypes for functions in input files"
  homepage "https://invisible-island.net/cproto/"
  url "https://invisible-mirror.net/archives/cproto/cproto-4.7t.tgz"
  mirror "https://deb.debian.org/debian/pool/main/c/cproto/cproto_4.7t.orig.tar.gz"
  sha256 "3cce82a71687b69e0a3e23489fe825ba72e693e559ccf193395208ac0eb96fe5"
  license all_of: [
    :public_domain,
    "MIT",
    "GPL-3.0-or-later" => { with: "Autoconf-exception-3.0" },
  ]

  livecheck do
    url "https://invisible-mirror.net/archives/cproto/"
    regex(/href=.*?cproto[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cproto"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a74b6597b8eb52609d7b7641c517c1cf67a7a6b8ea01762d09a3290ca782152e"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    (testpath/"woot.c").write("int woot() {\n}")
    assert_match(/int woot.void.;/, shell_output("#{bin}/cproto woot.c"))
  end
end
