class Goawk < Formula
  desc "POSIX-compliant AWK interpreter written in Go"
  homepage "https://benhoyt.com/writings/goawk/"
  url "https://github.com/benhoyt/goawk/archive/refs/tags/v1.18.0.tar.gz"
  sha256 "6d90e60364026445b028c6bc3ff9ed3745f87764e4f9b6688cb498d0639a65f0"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/goawk"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f554e2b6d7259576079d6462b714947fad70ee33d39960112be6c64566dcf7f4"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    output = pipe_output("#{bin}/goawk '{ gsub(/Macro/, \"Home\"); print }' -", "Macrobrew")
    assert_equal "Homebrew", output.strip
  end
end
