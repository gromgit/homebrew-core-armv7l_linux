class Tengo < Formula
  desc "Fast script language for Go"
  homepage "https://tengolang.com"
  url "https://github.com/d5/tengo/archive/v2.10.1.tar.gz"
  sha256 "00c892a7cb4e847eefd36f5b8db695e184da5c090c6b509339c3b5d3a746232f"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/tengo"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8848843fe0a49f970588ad1f525d7626781df24c1692a0887625f7d5ebf5ed93"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/tengo"
  end

  test do
    (testpath/"main.tengo").write <<~EOS
      fmt := import("fmt")

      each := func(seq, fn) {
          for x in seq { fn(x) }
      }

      sum := func(init, seq) {
          each(seq, func(x) { init += x })
          return init
      }

      fmt.println(sum(0, [1, 2, 3]))   // "6"
      fmt.println(sum("", [1, 2, 3]))  // "123"
    EOS
    assert_equal shell_output("#{bin}/tengo #{testpath}/main.tengo"), "6\n123\n"
  end
end
