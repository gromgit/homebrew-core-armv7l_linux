class Cig < Formula
  desc "CLI app for checking the state of your git repositories"
  homepage "https://github.com/stevenjack/cig"
  url "https://github.com/stevenjack/cig/archive/v0.1.5.tar.gz"
  sha256 "545a4a8894e73c4152e0dcf5515239709537e0192629dc56257fe7cfc995da24"
  license "MIT"
  head "https://github.com/stevenjack/cig.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cig"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8f02169141e84799541dda04e0e7450c55c481de77068339f31179a8989dc2d5"
  end

  depends_on "go" => :build

  # Patch to remove godep dependency.
  # Remove when the following PR is merged into release:
  # https://github.com/stevenjack/cig/pull/44
  patch do
    url "https://github.com/stevenjack/cig/compare/2d834ee..f0e78f0.patch?full_index"
    sha256 "3aa14ecfa057ec6aba08d6be3ea0015d9df550b4ede1c3d4eb76bdc441a59a47"
  end

  def install
    system "go", "build", *std_go_args
  end

  test do
    repo_path = "#{testpath}/test"
    system "git", "init", "--bare", repo_path
    (testpath/".cig.yaml").write <<~EOS
      test_project: #{repo_path}
    EOS
    system "#{bin}/cig", "--cp=#{testpath}"
  end
end
