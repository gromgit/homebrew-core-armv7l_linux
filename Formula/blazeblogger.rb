class Blazeblogger < Formula
  desc "CMS for the command-line"
  homepage "http://blaze.blackened.cz/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/blazeblogger/blazeblogger-1.2.0.tar.gz"
  sha256 "39024b70708be6073e8aeb3943eb3b73d441fbb7b8113e145c0cf7540c4921aa"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/blazeblogger"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "24b6cef0062ddaff7ee02205654f797f19ac62c5c29ba35fe3cab6b051bc2a05"
  end

  def install
    # https://code.google.com/p/blazeblogger/issues/detail?id=51
    ENV.deparallelize
    system "make", "prefix=#{prefix}", "compdir=#{prefix}", "install"
  end

  test do
    system bin/"blaze", "init"
    system bin/"blaze", "config", "blog.title", "Homebrew!"
    system bin/"blaze", "make"
    assert_predicate testpath/"default.css", :exist?
    assert_match "Homebrew!", File.read(".blaze/config")
  end
end
