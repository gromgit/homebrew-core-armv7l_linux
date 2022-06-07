class Cli53 < Formula
  desc "Command-line tool for Amazon Route 53"
  homepage "https://github.com/barnybug/cli53"
  url "https://github.com/barnybug/cli53/archive/0.8.18.tar.gz"
  sha256 "aa9ee59a52fc45f426680da48f45a79f2ac8365c15d8d7beed83a8ed71a891e4"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cli53"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "486b7d935f817caa6005edf43b9b2d8e31087ce250d8688be2b0d47ed5b2a441"
  end

  depends_on "go" => :build

  # Update AWS SDK. Fixes build on Go 1.18.
  # https://github.com/barnybug/cli53/pull/318
  patch do
    url "https://github.com/barnybug/cli53/commit/c60679c9171a4f8f04d09224ac4aacc316eed849.patch?full_index=1"
    sha256 "19842038d57cc78d738754772d4535cc59a77f9da3d00982dec533a565fa193d"
  end

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/cli53"
  end

  test do
    assert_match "list domains", shell_output("#{bin}/cli53 help list")
  end
end
