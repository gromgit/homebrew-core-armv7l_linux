class Crane < Formula
  desc "Tool for interacting with remote images and registries"
  homepage "https://github.com/google/go-containerregistry"
  url "https://github.com/google/go-containerregistry/archive/v0.9.0.tar.gz"
  sha256 "9cd3de5d5675ca79ff7251491c481f6afa54aa6a68bbbbf92613d66bfb39aa08"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/crane"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7de7b3b6288893f1e753f7d95822ff53704385239ef7408b8018579d9c375dec"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/google/go-containerregistry/cmd/crane/cmd.Version=#{version}
    ]

    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/crane"
  end

  test do
    json_output = shell_output("#{bin}/crane manifest gcr.io/go-containerregistry/crane")
    manifest = JSON.parse(json_output)
    assert_equal manifest["schemaVersion"], 2
  end
end
