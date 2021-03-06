class Elvish < Formula
  desc "Friendly and expressive shell"
  homepage "https://github.com/elves/elvish"
  url "https://github.com/elves/elvish/archive/v0.18.0.tar.gz"
  sha256 "f4635db90af2241bfd37e17ac1a72567b92d18a396598da2099a908b3d88c590"
  license "BSD-2-Clause"
  head "https://github.com/elves/elvish.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/elvish"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ad262bafe13014a66bfbd17577cefac576b63f559d28f7413cf8138fb7335a1c"
  end

  depends_on "go" => :build

  def install
    system "go", "build",
      *std_go_args(ldflags: "-s -w -X src.elv.sh/pkg/buildinfo.VersionSuffix="), "./cmd/elvish"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/elvish -version").chomp
    assert_match "hello", shell_output("#{bin}/elvish -c 'echo hello'")
  end
end
