class Dnsprobe < Formula
  desc "DNS query and resolution tool"
  homepage "https://github.com/projectdiscovery/dnsprobe"
  url "https://github.com/projectdiscovery/dnsprobe/archive/v1.0.3.tar.gz"
  sha256 "ab57f348177594018cc5b5b5e808710c88e597888c6d504cb10554d60627eae1"
  license "MIT"
  head "https://github.com/projectdiscovery/dnsprobe.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dnsprobe"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "be7f2aea277a157bb9350cfc84d7cebe0f5904e08ee0837863e9b4ae292b0168"
  end

  # repo deprecated in favor of `projectdiscovery/dnsx`
  deprecate! date: "2020-11-13", because: :repo_archived

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    (testpath/"domains.txt").write "docs.brew.sh"
    assert_match "docs.brew.sh homebrew.github.io.",
                 shell_output("#{bin}/dnsprobe -l domains.txt -r CNAME")
  end
end
