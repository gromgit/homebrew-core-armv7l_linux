class Sqlbench < Formula
  desc "Measures and compares the execution time of one or more SQL queries"
  homepage "https://github.com/felixge/sqlbench"
  url "https://github.com/felixge/sqlbench/archive/v1.1.0.tar.gz"
  sha256 "deaf4c299891ce75abff00429343eded76e8ddc8295d488938aa9ee418a7c9b3"
  license "MIT"
  head "https://github.com/felixge/sqlbench.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/sqlbench"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f2cfdbed9269c59871085121984f5e00a04878bf20c82c38028d7aaedd33f4d0"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
    pkgshare.install "examples"
  end

  test do
    cp_r pkgshare/"examples", testpath
    assert_match "failed to connect to",
      shell_output("#{bin}/sqlbench #{testpath}/examples/sum/*.sql 2>&1", 1)
  end
end
