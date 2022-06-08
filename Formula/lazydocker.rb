class Lazydocker < Formula
  desc "Lazier way to manage everything docker"
  homepage "https://github.com/jesseduffield/lazydocker"
  url "https://github.com/jesseduffield/lazydocker.git",
      tag:      "v0.18.1",
      revision: "da650f4384219e13e0dad3de266501aa0b06859c"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/lazydocker"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "59f96340eb539bdc9681d6536334cd30fdab311d5ed557fa2b0e7c4e7f806529"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-mod=vendor", "-o", bin/"lazydocker",
      "-ldflags", "-X main.version=#{version} -X main.buildSource=homebrew"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lazydocker --version")

    assert_match "language: auto", shell_output("#{bin}/lazydocker --config")
  end
end
