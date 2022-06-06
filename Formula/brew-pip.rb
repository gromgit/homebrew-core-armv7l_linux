class BrewPip < Formula
  desc "Install pip packages as homebrew formulae"
  homepage "https://github.com/hanxue/brew-pip"
  url "https://github.com/hanxue/brew-pip/archive/0.4.1.tar.gz"
  sha256 "9049a6db97188560404d8ecad2a7ade72a4be4338d5241097d3e3e8e215cda28"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/brew-pip"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "2e91f95ee46ac3e08aaf2a6d7f030c25609bf1f7089da131834010f5f69a8a56"
  end

  # Repository is not maintained in 9+ years
  deprecate! date: "2022-04-16", because: :unmaintained

  def install
    bin.install "bin/brew-pip"
  end

  test do
    system "#{bin}/brew-pip", "help"
  end
end
