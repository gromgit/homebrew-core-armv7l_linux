class Restic < Formula
  desc "Fast, efficient and secure backup program"
  homepage "https://restic.net/"
  url "https://github.com/restic/restic/archive/v0.13.1.tar.gz"
  sha256 "8430f80dc17b98fd78aca6f7d635bf12a486687677e15989a891ff4f6d8490a9"
  license "BSD-2-Clause"
  head "https://github.com/restic/restic.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/restic"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "012a29781658cefe9bd01772d176e62c8b27f127fddfafe19e88458243fb4b54"
  end

  depends_on "go" => :build

  def install
    system "go", "run", "build.go"

    mkdir "completions"
    system "./restic", "generate", "--bash-completion", "completions/restic"
    system "./restic", "generate", "--zsh-completion", "completions/_restic"

    mkdir "man"
    system "./restic", "generate", "--man", "man"

    bin.install "restic"
    bash_completion.install "completions/restic"
    zsh_completion.install "completions/_restic"
    man1.install Dir["man/*.1"]
  end

  test do
    mkdir testpath/"restic_repo"
    ENV["RESTIC_REPOSITORY"] = testpath/"restic_repo"
    ENV["RESTIC_PASSWORD"] = "foo"

    (testpath/"testfile").write("This is a testfile")

    system "#{bin}/restic", "init"
    system "#{bin}/restic", "backup", "testfile"

    system "#{bin}/restic", "restore", "latest", "-t", "#{testpath}/restore"
    assert compare_file "testfile", "#{testpath}/restore/testfile"
  end
end
