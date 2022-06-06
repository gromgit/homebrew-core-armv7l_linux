class Mage < Formula
  desc "Make/rake-like build tool using Go"
  homepage "https://magefile.org"
  url "https://github.com/magefile/mage.git",
      tag:      "v1.13.0",
      revision: "3504e09d7fcfdeab6e70281edce5d5dfb205f31a"
  license "Apache-2.0"
  head "https://github.com/magefile/mage.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mage"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c8e1e10c632578b49917429e06ae8e1752a96570c2740582cbed3eb068e26238"
  end

  depends_on "go"

  def install
    ldflags = %W[
      -s -w
      -X github.com/magefile/mage/mage.timestamp=#{time.rfc3339}
      -X github.com/magefile/mage/mage.commitHash=#{Utils.git_short_head}
      -X github.com/magefile/mage/mage.gitTag=#{version}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  test do
    assert_match "magefile.go created", shell_output("#{bin}/mage -init 2>&1")
    assert_predicate testpath/"magefile.go", :exist?
  end
end
