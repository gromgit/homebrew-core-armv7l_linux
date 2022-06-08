class Quran < Formula
  desc "Print Qur'an chapters and verses right in the terminal"
  homepage "https://git.hanabi.in/quran-go"
  url "https://git.hanabi.in/repos/quran-go.git",
      tag:      "v1.0.1",
      revision: "c0e271a69a2e817bf75c8ad79a1fc93aa1b868c9"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/quran"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "419bffabc74d884d4fc437a7c947c362e52c8544baab18d3eec522dcdc60ec8b"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "src/main.go"
  end

  test do
    op = shell_output("#{bin}/quran 1:1").strip
    assert_equal "In the Name of Allah—the Most Compassionate, Most Merciful.", op
  end
end
