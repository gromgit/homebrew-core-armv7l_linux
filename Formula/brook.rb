class Brook < Formula
  desc "Cross-platform strong encryption and not detectable proxy. Zero-Configuration"
  homepage "https://txthinking.github.io/brook/"
  url "https://github.com/txthinking/brook/archive/refs/tags/v20220515.tar.gz"
  sha256 "e054d0c3d0090b2015e9ff5e94a15b452a3e4e1de4588542972cc6c06965537b"
  license "GPL-3.0-only"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/brook"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1db0fcd095b21ea1688b2c2d512a76cdc3e153cf0c1b5959dc39fe0f1344f574"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cli/brook"
  end

  test do
    output = shell_output "#{bin}/brook link --server 1.2.3.4:56789 --password hello"
    # We expect something like "brook://server?password=hello&server=1.2.3.4%3A56789&username="
    uri = URI(output)
    assert_equal "brook", uri.scheme
    assert_equal "server", uri.host

    query = URI.decode_www_form(uri.query).to_h
    assert_equal "1.2.3.4:56789", query["server"]
    assert_equal "hello", query["password"]
    assert_equal "", query["username"]
  end
end
