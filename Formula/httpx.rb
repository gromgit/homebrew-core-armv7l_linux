class Httpx < Formula
  desc "Fast and multi-purpose HTTP toolkit"
  homepage "https://github.com/projectdiscovery/httpx"
  url "https://github.com/projectdiscovery/httpx/archive/v1.2.1.tar.gz"
  sha256 "ff7c623adc0594ba3da2f4f806513c0542bb4da32ea0ddcd3ee0f4413b0217da"
  license "MIT"
  head "https://github.com/projectdiscovery/httpx.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/httpx"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e10eac1c2d4f57bf3524696513febfd9f2ba057bae5c79bb40f9a66118b3d99f"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/httpx"
  end

  test do
    output = JSON.parse(pipe_output("#{bin}/httpx -silent -status-code -title -json", "example.org"))
    assert_equal 200, output["status-code"]
    assert_equal "Example Domain", output["title"]
  end
end
