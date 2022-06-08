class Plow < Formula
  desc "High-performance and real-time metrics displaying HTTP benchmarking tool"
  homepage "https://github.com/six-ddc/plow"
  url "https://github.com/six-ddc/plow/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "bd57418d6842ae79a675ede027cd986d1e719edb163febfaec812d1a7cde4304"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/plow"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "2c2bb4678f603c2710143967e0488ee6eb07f9d33f2c119c8dad8bccffe1c53c"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    output = "2xx"
    assert_match output.to_s, shell_output("#{bin}/plow -n 1 https://httpbin.org/get")
  end
end
