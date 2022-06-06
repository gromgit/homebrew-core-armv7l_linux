class Brev < Formula
  desc "CLI tool for managing workspaces provided by brev.dev"
  homepage "https://docs.brev.dev"
  url "https://github.com/brevdev/brev-cli/archive/refs/tags/v0.6.67.tar.gz"
  sha256 "77621c381242d8a1d7ba3d76a9c675982840d4a1cbada300dfad4b08adde3924"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/brev"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "cd4eaad94de03a7913fc79a84bf47eabeccab32dd5de2c927410ca5d7438d9df"
  end

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/brevdev/brev-cli/pkg/cmd/version.Version=v#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  test do
    system bin/"brev", "healthcheck"
  end
end
