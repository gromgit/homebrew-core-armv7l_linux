class Jid < Formula
  desc "Json incremental digger"
  homepage "https://github.com/simeji/jid"
  url "https://github.com/simeji/jid/archive/v0.7.6.tar.gz"
  sha256 "0912050b3be3760804afaf7ecd6b42bfe79e7160066587fbc0afa5324b03fb48"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/jid"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ecd601866cd9323291bb2e1db9261e1f7ef20bbbf09a85d8d8cf5e2eebb1c6b9"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", "-trimpath", "-o", bin/"jid", "cmd/jid/jid.go"
    prefix.install_metafiles
  end

  test do
    assert_match "jid version v#{version}", shell_output("#{bin}/jid --version")
  end
end
