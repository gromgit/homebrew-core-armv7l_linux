class Ioctl < Formula
  desc "Command-line interface for interacting with the IoTeX blockchain"
  homepage "https://docs.iotex.io/"
  url "https://github.com/iotexproject/iotex-core/archive/v1.8.0.tar.gz"
  sha256 "0ff566ca690801e5bdce8d24532e23a5a6e7f1969ead1e6f519651b9fabac352"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ioctl"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "9abf386b887718b955cff0a2223ea83188a4db018afbdfca918dff45e1be4ec1"
  end

  depends_on "go" => :build

  def install
    system "make", "ioctl"
    bin.install "bin/ioctl"
  end

  test do
    output = shell_output "#{bin}/ioctl config set endpoint api.iotex.one:443"
    assert_match "Endpoint is set to api.iotex.one:443", output
  end
end
