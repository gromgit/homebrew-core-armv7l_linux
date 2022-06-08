class Lxc < Formula
  desc "CLI client for interacting with LXD"
  homepage "https://linuxcontainers.org"
  url "https://linuxcontainers.org/downloads/lxd/lxd-5.2.tar.gz"
  sha256 "e22d2b34a1848d33b2080b2b1c82355afb6d36fdfe49e67f44b3749edbc02e4c"
  license "Apache-2.0"

  livecheck do
    url "https://linuxcontainers.org/lxd/downloads/"
    regex(/href=.*?lxd[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/lxc"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "fda78295ba395e93d7d943095d044a950831a320a70fb9b6538db1935510c7dd"
  end

  depends_on "go" => :build

  def install
    ENV["GOBIN"] = bin

    system "go", "build", *std_go_args, "./lxc"
  end

  test do
    system "#{bin}/lxc", "--version"
  end
end
