class Psgrep < Formula
  desc "Shortcut for the 'ps aux | grep' idiom"
  homepage "https://github.com/jvz/psgrep"
  url "https://github.com/jvz/psgrep/archive/1.0.9.tar.gz"
  sha256 "6408e4fc99414367ad08bfbeda6aa86400985efe1ccb1a1f00f294f86dd8b984"
  license "GPL-3.0-or-later"
  head "https://github.com/jvz/psgrep.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/psgrep"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "aa24b08ce30fdeeb71c5fd8be9f062cc0e29fc577d6d5f783088936acd2013dd"
  end

  def install
    bin.install "psgrep"
    man1.install "psgrep.1"
  end

  test do
    assert_match $PROGRAM_NAME, shell_output("#{bin}/psgrep #{Process.pid}")
  end
end
