class GoogleSparsehash < Formula
  desc "Extremely memory-efficient hash_map implementation"
  homepage "https://github.com/sparsehash/sparsehash"
  url "https://github.com/sparsehash/sparsehash/archive/sparsehash-2.0.4.tar.gz"
  sha256 "8cd1a95827dfd8270927894eb77f62b4087735cbede953884647f16c521c7e58"
  license "BSD-3-Clause"
  head "https://github.com/sparsehash/sparsehash.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/google-sparsehash"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "18714795cfeeeaed655d978a981e4c831fe39e46743ed79c0c219c695cf281e3"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "check"
    system "make", "install"
  end
end
