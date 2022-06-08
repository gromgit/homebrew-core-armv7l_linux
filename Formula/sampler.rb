class Sampler < Formula
  desc "Tool for shell commands execution, visualization and alerting"
  homepage "https://sampler.dev"
  url "https://github.com/sqshq/sampler/archive/v1.1.0.tar.gz"
  sha256 "8b60bc5c0f94ddd4291abc2b89c1792da424fa590733932871f7b5e07e7587f9"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/sampler"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8e7cfce6f04db1c1597eb5540170d729dfefba0ecf5a4812025535665c687fea"
  end

  depends_on "go" => :build

  on_linux do
    depends_on "alsa-lib"
  end

  def install
    system "go", "build", "-o", bin/"sampler"
  end

  test do
    assert_includes "specify config file", shell_output("#{bin}/sampler")
  end
end
