class Certstrap < Formula
  desc "Tools to bootstrap CAs, certificate requests, and signed certificates"
  homepage "https://github.com/square/certstrap"
  url "https://github.com/square/certstrap/archive/v1.2.0.tar.gz"
  sha256 "0eebcc515ca1a3e945d0460386829c0cdd61e67c536ec858baa07986cb5e64f8"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/certstrap"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f60898f1596a68ace9063563d9987e15a17944c2c9117f61836363ae43129328"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w -X main.version=#{version}", "-trimpath", "-o", bin/"certstrap"
    prefix.install_metafiles
  end

  test do
    system "#{bin}/certstrap", "init", "--common-name", "Homebrew Test CA", "--passphrase", "beerformyhorses"
  end
end
