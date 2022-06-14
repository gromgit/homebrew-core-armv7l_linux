class GitIf < Formula
  desc "Glulx interpreter that is optimized for speed"
  homepage "https://ifarchive.org/indexes/if-archiveXprogrammingXglulxXinterpretersXgit.html"
  url "https://ifarchive.org/if-archive/programming/glulx/interpreters/git/git-136.zip"
  version "1.3.6"
  sha256 "28d8d7b8d81dac65c19f0b994d54b3c34b182045e86ca399fea65934918d1cf3"
  license "MIT"
  head "https://github.com/DavidKinder/Git.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/git-if"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ff1cf4ec67fc3fa9cce34a95a126ba729178d82b0a9a98cb7b6d7f3e69926797"
  end

  depends_on "glktermw" => :build

  uses_from_macos "ncurses"

  def install
    glk = Formula["glktermw"]

    inreplace "Makefile", "GLK = cheapglk", "GLK = #{glk.name}"
    inreplace "Makefile", "GLKINCLUDEDIR = ../$(GLK)", "GLKINCLUDEDIR = #{glk.include}"
    inreplace "Makefile", "GLKLIBDIR = ../$(GLK)", "GLKLIBDIR = #{glk.lib}"
    inreplace "Makefile", /^OPTIONS = /, "OPTIONS = -DUSE_MMAP -DUSE_INLINE"

    system "make"
    bin.install "git" => "git-if"
  end

  test do
    assert pipe_output("#{bin}/git-if -v").start_with? "GlkTerm, library version"
  end
end
