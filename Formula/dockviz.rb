class Dockviz < Formula
  desc "Visualizing docker data"
  homepage "https://github.com/justone/dockviz"
  url "https://github.com/justone/dockviz.git",
      tag:      "v0.6.3",
      revision: "15f77275c4f7e459eb7d9f824b5908c165cd0ba4"
  license "Apache-2.0"
  head "https://github.com/justone/dockviz.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dockviz"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8dae7ce078799659289f164154fcf9fd1a4d931b94bea5b7bb5523a3ef05726f"
  end

  depends_on "go" => :build
  depends_on "govendor" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"

    (buildpath/"src/github.com/justone/dockviz").install buildpath.children
    cd "src/github.com/justone/dockviz" do
      system "govendor", "sync"
      system "go", "build", "-o", bin/"dockviz"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dockviz --version")
  end
end
