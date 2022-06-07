class Chroma < Formula
  desc "General purpose syntax highlighter in pure Go"
  homepage "https://github.com/alecthomas/chroma"
  url "https://github.com/alecthomas/chroma/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "5d6b9986a175ed8ca789e55e42bb4d0f6089b408824b0654b57c7fcb91c06c07"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/chroma"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3a550a959bdeccc9d33734565a06fb50431b426588efbd4f934ce6f704f4a41f"
  end

  depends_on "go" => :build

  def install
    cd "cmd/chroma" do
      system "go", "build", *std_go_args(ldflags: "-s -w")
    end
  end

  test do
    json_output = JSON.parse(shell_output("#{bin}/chroma --json #{test_fixtures("test.diff")}"))
    assert_equal "GenericHeading", json_output[0]["type"]
  end
end
