class Masscan < Formula
  desc "TCP port scanner, scans entire Internet in under 5 minutes"
  homepage "https://github.com/robertdavidgraham/masscan/"
  url "https://github.com/robertdavidgraham/masscan/archive/1.3.2.tar.gz"
  sha256 "0363e82c07e6ceee68a2da48acd0b2807391ead9a396cf9c70b53a2a901e3d5f"
  license "AGPL-3.0-only"
  head "https://github.com/robertdavidgraham/masscan.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/masscan"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3f8b31157ef67aebe3f0b9fa600c1b5d3995d7166d40ecedff39dce13c17b79d"
  end

  def install
    # Fix `dyld: lazy symbol binding failed: Symbol not found: _clock_gettime`
    # Reported 8 July 2017: https://github.com/robertdavidgraham/masscan/issues/284
    if MacOS.version == :el_capitan && MacOS::Xcode.version >= "8.0"
      inreplace "src/pixie-timer.c", "#elif defined(CLOCK_MONOTONIC)", "#elif defined(NOT_A_MACRO)"
    end

    system "make"
    bin.install "bin/masscan"
  end

  test do
    assert_match "ports =", shell_output("#{bin}/masscan --echo")
  end
end
