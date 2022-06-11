class Clockywock < Formula
  desc "Ncurses analog clock"
  homepage "https://web.archive.org/web/20210519013044/https://soomka.com/"
  url "https://web.archive.org/web/20160401181746/https://soomka.com/clockywock-0.3.1a.tar.gz"
  mirror "https://mirrors.kernel.org/gentoo/distfiles/11/clockywock-0.3.1a.tar.gz"
  sha256 "278c01e0adf650b21878e593b84b3594b21b296d601ee0f73330126715a4cce4"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/clockywock"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "cf3d2a4a744564ef9dfe4cf7b0465f9efcfa8bf93976365f85e83e60018c6eb2"
  end

  deprecate! date: "2022-03-30", because: :unmaintained

  uses_from_macos "ncurses"

  def install
    system "make"
    bin.install "clockywock"
    man7.install "clockywock.7"
  end

  test do
    system "#{bin}/clockywock", "-h"
  end
end
