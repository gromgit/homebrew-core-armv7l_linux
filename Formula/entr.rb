class Entr < Formula
  desc "Run arbitrary commands when files change"
  homepage "https://eradman.com/entrproject/"
  url "https://eradman.com/entrproject/code/entr-5.2.tar.gz"
  sha256 "237e309d46b075210c0e4cb789bfd0c9c777eddf6cb30341c3fe3dbcc658c380"
  license "ISC"
  head "https://github.com/eradman/entr.git", branch: "master"

  livecheck do
    url "https://eradman.com/entrproject/code/"
    regex(/href=.*?entr[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/entr"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "0e69897fad635a4d8abeac93e7a475938d5ddfb7d732bdc06d25e2e01b7cff1b"
  end

  def install
    ENV["PREFIX"] = prefix
    ENV["MANPREFIX"] = man
    system "./configure"
    system "make"
    system "make", "install"
  end

  test do
    touch testpath/"test.1"
    fork do
      sleep 0.5
      touch testpath/"test.2"
    end
    assert_equal "New File", pipe_output("#{bin}/entr -n -p -d echo 'New File'", testpath).strip
  end
end
