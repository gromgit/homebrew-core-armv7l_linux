class Pmccabe < Formula
  desc "Calculate McCabe-style cyclomatic complexity for C/C++ code"
  homepage "https://gitlab.com/pmccabe/pmccabe"
  url "https://gitlab.com/pmccabe/pmccabe/-/archive/v2.8/pmccabe-v2.8.tar.bz2"
  sha256 "d37cafadfb64507c32d75297193f99f1afcf12289b7fcc1ddde4a852f0f2ac8a"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:[._]\d+)+[a-z]?)$/i)
    strategy :git do |tags, regex|
      tags.map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pmccabe"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "48f761b7f6234484080e184f67dd98ceaa65e17b07a5a7c12cdc92d52bdcad61"
  end

  def install
    ENV.append_to_cflags "-D__unix"

    system "make", "CFLAGS=#{ENV.cflags}"
    bin.install "pmccabe", "codechanges", "decomment", "vifn"
    man1.install Dir["*.1"]
  end

  test do
    assert_match "pmccabe #{version}", shell_output("#{bin}/pmccabe -V")
  end
end
