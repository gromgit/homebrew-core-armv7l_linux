class Karn < Formula
  desc "Manage multiple Git identities"
  homepage "https://github.com/prydonius/karn"
  url "https://github.com/prydonius/karn/archive/v0.0.5.tar.gz"
  sha256 "bb3e6d93a4202cde22f8ea0767c994dfebd018fba1f4c1876bf9ab0e765aa45c"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/karn"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "99e496241221e4b9e78aadbed62fb7503e1da54972144fc821d3351d32c6c055"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/karn/karn.go"
  end

  test do
    (testpath/".karn.yml").write <<~EOS
      ---
      #{testpath}:
        name: Homebrew Test
        email: test@brew.sh
    EOS
    system "git", "init"
    system "git", "config", "--global", "user.name", "Test"
    system "git", "config", "--global", "user.email", "test@test.com"
    system "#{bin}/karn", "update"
  end
end
