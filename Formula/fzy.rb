class Fzy < Formula
  desc "Fast, simple fuzzy text selector with an advanced scoring algorithm"
  homepage "https://github.com/jhawthorn/fzy"
  url "https://github.com/jhawthorn/fzy/releases/download/1.0/fzy-1.0.tar.gz"
  sha256 "80257fd74579e13438b05edf50dcdc8cf0cdb1870b4a2bc5967bd1fdbed1facf"
  license "MIT"
  head "https://github.com/jhawthorn/fzy.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fzy"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "2f36c4e18fc0679aadef943b2280ed816e25efcd41d99775e7ac8bb021c089fb"
  end

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_equal "foo", pipe_output("#{bin}/fzy -e foo", "bar\nfoo\nqux").chomp
  end
end
