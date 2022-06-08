class Hey < Formula
  desc "HTTP load generator, ApacheBench (ab) replacement"
  homepage "https://github.com/rakyll/hey"
  url "https://github.com/rakyll/hey/archive/v0.1.4.tar.gz"
  sha256 "944097e62dd0bd5012d3b355d9fe2e7b7afcf13cc0b2c06151e0f4c2babfc279"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/hey"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1fd4ddcea6c0b1e80755fb86cfcd39a9df4293a2cca19028dfe335f6d5be56a4"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    output = "[200]	200 responses"
    assert_match output.to_s, shell_output("#{bin}/hey https://google.com")
  end
end
