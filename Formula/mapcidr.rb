class Mapcidr < Formula
  desc "Subnet/CIDR operation utility"
  homepage "https://projectdiscovery.io"
  url "https://github.com/projectdiscovery/mapcidr/archive/v0.0.9.tar.gz"
  sha256 "997de8dd52581eeee2a065f7ffe10742ae82d97dcbc3e87d1abe5f696a6d9880"
  license "MIT"
  head "https://github.com/projectdiscovery/mapcidr.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mapcidr"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "26b0a34aeb95b94bbb8a45ee4aa7ce45a0d00e0e4ad2a6ac285890c4fb7eb9f0"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/mapcidr"
  end

  test do
    expected = "192.168.0.0/18\n192.168.64.0/18\n192.168.128.0/18\n192.168.192.0/18\n"
    output = shell_output("#{bin}/mapcidr -cidr 192.168.1.0/16 -sbh 16384 -silent")
    assert_equal expected, output
  end
end
