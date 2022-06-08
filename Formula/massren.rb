class Massren < Formula
  desc "Easily rename multiple files using your text editor"
  homepage "https://github.com/laurent22/massren"
  url "https://github.com/laurent22/massren/archive/v1.5.6.tar.gz"
  sha256 "49758b477a205f3fbf5bbe72c2575fff8b5536f8c6b45f8f6bd2fdde023ce874"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/massren"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "107ae219cd56303599603d90c9aa50ffbadfd7db4e1e611d54e7b4dbe294a9f4"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    (buildpath/"src/github.com/laurent22/massren").install buildpath.children
    cd "src/github.com/laurent22/massren" do
      system "go", "build", "-o", bin/"massren"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"massren", "--config", "editor", "nano"
    assert_match 'editor = "nano"', shell_output("#{bin}/massren --config")
  end
end
