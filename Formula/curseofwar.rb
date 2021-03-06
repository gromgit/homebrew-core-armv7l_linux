class Curseofwar < Formula
  desc "Fast-paced action strategy game"
  homepage "https://a-nikolaev.github.io/curseofwar/"
  url "https://github.com/a-nikolaev/curseofwar/archive/v1.3.0.tar.gz"
  sha256 "2a90204d95a9f29a0e5923f43e65188209dc8be9d9eb93576404e3f79b8a652b"
  license "GPL-3.0"
  head "https://github.com/a-nikolaev/curseofwar.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/curseofwar"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "33ed6181a1ca7cdfbcfde39f37b565f6f5467a733e26ef9407646190304882e9"
  end

  uses_from_macos "ncurses"

  def install
    system "make", "VERSION=#{version}"
    bin.install "curseofwar"
    man6.install "curseofwar.6"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/curseofwar -v", 1).chomp
  end
end
