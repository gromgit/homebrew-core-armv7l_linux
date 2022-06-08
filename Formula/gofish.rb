class Gofish < Formula
  desc "Cross-platform systems package manager"
  homepage "https://gofi.sh"
  url "https://github.com/fishworks/gofish.git",
      tag:      "v0.15.1",
      revision: "5d14f73963cfc0c226e8b06c0f5c3404d2ec2e77"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gofish"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a67a292d9fd63952237472e122b1d75e5e6fd032899268fff16c6f1c73634e24"
  end

  depends_on "go" => :build

  def install
    system "make"
    bin.install "bin/gofish"
  end

  def caveats
    <<~EOS
      To activate gofish, run:
        gofish init
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/gofish version")
  end
end
