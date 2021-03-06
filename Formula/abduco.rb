class Abduco < Formula
  desc "Provides session management: i.e. separate programs from terminals"
  homepage "https://www.brain-dump.org/projects/abduco"
  url "https://github.com/martanne/abduco/releases/download/v0.6/abduco-0.6.tar.gz"
  sha256 "c90909e13fa95770b5afc3b59f311b3d3d2fdfae23f9569fa4f96a3e192a35f4"
  license "ISC"
  head "https://github.com/martanne/abduco.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/abduco"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e61947cfe4cad62cc4c12734d54ae7e17df9b57f683c52d2e6acf2b559faae1e"
  end

  def install
    ENV.append_to_cflags "-D_DARWIN_C_SOURCE"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    result = shell_output("#{bin}/abduco -v")
    result.force_encoding("UTF-8") if result.respond_to?(:force_encoding)
    assert_match(/^abduco-#{version}/, result)
  end
end
