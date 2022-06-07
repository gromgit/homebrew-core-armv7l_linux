class ForkCleaner < Formula
  desc "Cleans up old and inactive forks on your GitHub account"
  homepage "https://github.com/caarlos0/fork-cleaner"
  url "https://github.com/caarlos0/fork-cleaner/archive/v2.2.1.tar.gz"
  sha256 "24397ec0ad89738aee48b77e80033a2e763941e67e67b673b6ff86ab04367283"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fork-cleaner"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1e0157487ebf8e3976bb334ca957e44253bb4e532fff82a4b48773dcf37b5075"
  end

  depends_on "go" => :build

  def install
    system "make"
    bin.install "fork-cleaner"
    prefix.install_metafiles
  end

  test do
    output = shell_output("#{bin}/fork-cleaner 2>&1", 1)
    assert_match "missing github token", output
  end
end
