class Nodenv < Formula
  desc "Manage multiple NodeJS versions"
  homepage "https://github.com/nodenv/nodenv"
  url "https://github.com/nodenv/nodenv/archive/v1.4.0.tar.gz"
  sha256 "33e2f3e467219695ba114f75a7c769f3ee4e29b29c1c97a852aa001327ca9713"
  license "MIT"
  head "https://github.com/nodenv/nodenv.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/nodenv"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7a5a8d4c32a65d8e82785df15877f341532379d36b0ca2d9b8f4160ead998de3"
  end

  depends_on "node-build"

  def install
    inreplace "libexec/nodenv" do |s|
      s.gsub! "/usr/local", HOMEBREW_PREFIX
      s.gsub! '"${BASH_SOURCE%/*}"/../libexec', libexec
    end

    %w[--version hooks versions].each do |cmd|
      inreplace "libexec/nodenv-#{cmd}", "${BASH_SOURCE%/*}", libexec
    end

    # Compile bash extension
    system "src/configure"
    system "make", "-C", "src"

    if build.head?
      # Record exact git revision for `nodenv --version` output
      inreplace "libexec/nodenv---version", /^(version=.+)/,
                                           "\\1--g#{Utils.git_short_head}"
    end

    prefix.install "bin", "completions", "libexec"
  end

  test do
    shell_output("eval \"$(#{bin}/nodenv init -)\" && nodenv --version")
  end
end
