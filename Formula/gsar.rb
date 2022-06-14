class Gsar < Formula
  desc "General Search And Replace on files"
  homepage "http://tjaberg.com/"
  url "http://tjaberg.com/gsar151.zip"
  version "1.51"
  sha256 "72908ae302d2293de5218fd4da0b98afa2ce8890a622e709360576e93f5e8cc8"
  license "GPL-2.0-only"

  # gsar archive file names don't include a version string with dots (e.g., 123
  # instead of 1.23), so we identify versions from the text of the "Changes"
  # section.
  livecheck do
    url :homepage
    regex(/gsar v?(\d+(?:\.\d+)+) released/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gsar"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "2fb3f5c0bdf8442fb88d24d83f72e0319f5729f303c1c8b482b7e796cf3c9932"
  end

  def install
    system "make"
    bin.install "gsar"
  end

  test do
    assert_match "1 occurrence changed",
      shell_output("#{bin}/gsar -sCourier -rMonaco #{test_fixtures("test.ps")} new.ps")
  end
end
