class Rsc2fa < Formula
  desc "Two-factor authentication on the command-line"
  homepage "https://pkg.go.dev/rsc.io/2fa"
  url "https://github.com/rsc/2fa/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "d8db6b9a714c9146a4b82fd65b54f9bdda3e58380bce393f45e1ef49e4e9bee5"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/rsc_2fa"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "db3fbb21346e04936b97994ba5c8d74b1734b50660cdf719c4c2bc4334dcf5b1"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-mod=mod", "-o", bin/"2fa"
  end

  test do
    out = shell_output("#{bin}/2fa -help 2>&1", 2)
    assert_match(/^usage:/, out)

    out = shell_output("echo AAAAAAAAAAAAAAAA | #{bin}/2fa -add example 2>&1")
    assert_match(/^2fa key for example:/, out)

    out = shell_output("#{bin}/2fa example")
    assert_match(/^[0-9]{6}\n$/, out)
  end
end
