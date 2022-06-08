class Goad < Formula
  desc "AWS Lambda powered, highly distributed, load testing tool built in Go"
  homepage "https://goad.io/"
  url "https://github.com/goadapp/goad.git",
      tag:      "2.0.4",
      revision: "e015a55faa940cde2bc7b38af65709d52235eaca"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/goad"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "dcc1e2e5cac966db8d4e3e79779a205a3ae1b9e1ce6bff9abced1a95e06d862e"
  end

  deprecate! date: "2020-11-27", because: :repo_archived

  depends_on "go" => :build
  depends_on "go-bindata" => :build

  uses_from_macos "zip" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    dir = buildpath/"src/github.com/goadapp/goad"
    dir.install buildpath.children

    cd dir do
      system "make", "build"
      bin.install "build/goad"
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/goad", "--version"
  end
end
