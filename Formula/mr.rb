class Mr < Formula
  desc "Multiple Repository management tool"
  homepage "https://myrepos.branchable.com/"
  url "git://myrepos.branchable.com/",
      tag:      "1.20180726",
      revision: "0ad7a17bb455de1fec3b2375c7aac72ab2a22ac4"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mr"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "9869a8ce9315abaeda8e2f161042942addcce17be991df6a6ed2374f828ab7cf"
  end

  resource("test-repo") do
    url "https://github.com/Homebrew/homebrew-command-not-found.git"
  end

  def install
    system "make"
    bin.install "mr", "webcheckout"
    man1.install gzip("mr.1", "webcheckout.1")
    pkgshare.install Dir["lib/*"]
  end

  test do
    resource("test-repo").stage do
      system bin/"mr", "register"
      assert_match(/^mr status: #{Dir.pwd}$/, shell_output("#{bin}/mr status"))
    end
  end
end
