class Counterfeiter < Formula
  desc "Tool for generating self-contained, type-safe test doubles in go"
  homepage "https://github.com/maxbrunsfeld/counterfeiter"
  url "https://github.com/maxbrunsfeld/counterfeiter/archive/refs/tags/v6.5.0.tar.gz"
  sha256 "a03c3f1428bbb29cd0a050bb4732c94000b7edd769f6863b5447d2c07bd06695"
  license "MIT"
  revision 1
  head "https://github.com/maxbrunsfeld/counterfeiter.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/counterfeiter"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1f442a4310a334b54e2b8bfacba9c4797fd551e9c1e19abb57b683dab128f8d0"
  end

  depends_on "go"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    ENV["GOROOT"] = Formula["go"].opt_libexec

    output = shell_output("#{bin}/counterfeiter -p os 2>&1")
    assert_predicate testpath/"osshim", :exist?
    assert_match "Writing `Os` to `osshim/os.go`...", output

    output = shell_output("#{bin}/counterfeiter -generate 2>&1", 1)
    assert_match "no buildable Go source files", output
  end
end
