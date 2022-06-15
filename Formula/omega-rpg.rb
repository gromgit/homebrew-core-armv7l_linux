class OmegaRpg < Formula
  desc "Classic Roguelike game"
  homepage "http://www.alcyone.com/max/projects/omega/"
  url "http://www.alcyone.com/binaries/omega/omega-0.80.2-src.tar.gz"
  sha256 "60164319de90b8b5cae14f2133a080d5273e5de3d11c39df080a22bbb2886104"
  revision 1

  livecheck do
    url :homepage
    regex(/latest.*?>v?(\d+(?:\.\d+)+)</i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/omega-rpg"
    sha256 armv7l_linux: "5ea11a6a18f41cf42b50ff4569271c5c4ca38b6eedf9d2ab81e47136d4931ff2"
  end

  uses_from_macos "ncurses"

  def install
    # Set up our target folders
    inreplace "defs.h", "#define OMEGALIB \"./omegalib/\"", "#define OMEGALIB \"#{libexec}/\""

    # Don't alias CC; also, don't need that ncurses include path
    # Set the system type in CFLAGS, not in makefile
    # Remove an obsolete flag
    inreplace "Makefile" do |s|
      s.remove_make_var! ["CC", "CFLAGS", "LDFLAGS"]
    end

    ENV.append_to_cflags "-DUNIX -DSYSV"

    system "make"

    # 'make install' is weird, so we do it ourselves
    bin.install "omega"
    libexec.install Dir["omegalib/*"]
  end

  def post_install
    # omega refuses to run without license.txt in OMEGALIB
    license_file = libexec/"license.txt"
    prefix.install_symlink license_file unless license_file.exist?
  end
end
