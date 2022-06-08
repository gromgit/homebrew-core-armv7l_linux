class Govc < Formula
  desc "Command-line tool for VMware vSphere"
  homepage "https://github.com/vmware/govmomi/tree/master/govc"
  url "https://github.com/vmware/govmomi/archive/v0.28.0.tar.gz"
  sha256 "6bfc60ff105b0ea2839f574bc84e9f66d5886c2a7769c359686b01a49818651f"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/govc"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8996b485a270bb00fe30a0d1c842a5cf56dbc9ace4e704743fe424b83030b61b"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", "#{bin}/#{name}", "./#{name}"
  end

  test do
    assert_match "GOVC_URL=foo", shell_output("#{bin}/#{name} env -u=foo")
  end
end
