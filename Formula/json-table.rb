class JsonTable < Formula
  desc "Transform nested JSON data into tabular data in the shell"
  homepage "https://github.com/micha/json-table"
  url "https://github.com/micha/json-table/archive/4.3.3.tar.gz"
  sha256 "0ab7bb2a705ad3399132060b30b32903762473ff79b5a6e6f52f086e507b0911"
  license "EPL-1.0"
  head "https://github.com/micha/json-table.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/json-table"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "5d881f2c130be31810e91f089375697de1caa68e404fc716f7f9dac3171dec66"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    output = pipe_output("#{bin}/jt x y %", '{"x":{"y":[1,2,3]}}', 0)
    assert_equal "3", output.lines.last.chomp
  end
end
