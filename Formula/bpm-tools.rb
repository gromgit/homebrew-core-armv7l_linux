class BpmTools < Formula
  desc "Detect tempo of audio files using beats-per-minute (BPM)"
  homepage "https://www.pogo.org.uk/~mark/bpm-tools/"
  url "https://www.pogo.org.uk/~mark/bpm-tools/releases/bpm-tools-0.3.tar.gz"
  sha256 "37efe81ef594e9df17763e0a6fc29617769df12dfab6358f5e910d88f4723b94"
  license "GPL-2.0"
  head "https://www.pogo.org.uk/~mark/bpm-tools.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?bpm-tools[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bpm-tools"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8e6015d133a7b906a07e8ae7d42f34c936e5c82153a2b4a8aba901edac48c123"
  end

  def install
    system "make"
    bin.install "bpm"
    bin.install "bpm-tag"
  end
end
