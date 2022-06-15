class Pacvim < Formula
  desc "Learn vim commands via a game"
  homepage "https://github.com/jmoon018/PacVim"
  url "https://github.com/jmoon018/PacVim/archive/v1.1.1.tar.gz"
  sha256 "c869c5450fbafdfe8ba8a8a9bba3718775926f276f0552052dcfa090d21acb28"
  license "LGPL-3.0-or-later"
  head "https://github.com/jmoon018/PacVim.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pacvim"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7a2537612fc02d7604ca9d5eb8070576ceea85baa7bf6cb12c7a982216bf56ca"
  end

  uses_from_macos "ncurses"

  on_linux do
    # Use ncurses.h instead of cursesw.h which is not installed by brew
    # https://github.com/jmoon018/PacVim/pull/31
    patch do
      url "https://github.com/jmoon018/PacVim/commit/2f95ef4d312d760b8a3aae463e959646b27e774a.patch?full_index=1"
      sha256 "e5b753de87937c0853a1adbab31eb1ec938add4ceb0df26eafef5b4f613bc3e6"
    end
  end

  def install
    ENV.cxx11
    system "make", "install", "PREFIX=#{prefix}"
  end
end
