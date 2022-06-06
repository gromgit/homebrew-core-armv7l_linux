class Azcopy < Formula
  desc "Azure Storage data transfer utility"
  homepage "https://github.com/Azure/azure-storage-azcopy"
  url "https://github.com/Azure/azure-storage-azcopy/archive/v10.15.0.tar.gz"
  sha256 "f850ee5f3d45d3769d9929a98abc3d2b997e90ad4fd6dc49a487b248e6e8d78c"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/azcopy"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "298926e286e61f69cb8c6c50dac2972442ddd4277e64c621e3f8272f427d07b7"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "failed to obtain credential info",
                 shell_output("#{bin}/azcopy list https://storageaccountname.blob.core.windows.net/containername/", 1)
  end
end
