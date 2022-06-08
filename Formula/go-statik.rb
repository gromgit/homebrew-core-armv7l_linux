class GoStatik < Formula
  desc "Embed files into a Go executable"
  homepage "https://github.com/rakyll/statik"
  url "https://github.com/rakyll/statik/archive/v0.1.7.tar.gz"
  sha256 "cd05f409e63674f29cff0e496bd33eee70229985243cce486107085fab747082"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/go-statik"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "5ff15da112e5bca7fac57b619afc7fe289d5dfcf6c1525d838b415faf63f7706"
  end

  depends_on "go" => :build

  conflicts_with "statik", because: "both install `statik` binaries"

  def install
    system "go", "build", *std_go_args(output: bin/"statik", ldflags: "-s -w")
  end

  test do
    font_name = (MacOS.version >= :catalina) ? "Arial Unicode.ttf" : "Arial.ttf"
    font_path = if OS.mac?
      "/Library/Fonts/#{font_name}"
    else
      "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
    end
    system bin/"statik", "-src", font_path
    assert_predicate testpath/"statik/statik.go", :exist?
    refute_predicate (testpath/"statik/statik.go").size, :zero?
  end
end
