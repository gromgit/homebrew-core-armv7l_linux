class Awk < Formula
  desc "Text processing scripting language"
  homepage "https://www.cs.princeton.edu/~bwk/btl.mirror/"
  url "https://github.com/onetrueawk/awk/archive/20220122.tar.gz"
  sha256 "720a06ff8dcc12686a5176e8a4c74b1295753df816e38468a6cf077562d54042"
  # https://fedoraproject.org/wiki/Licensing:MIT?rd=Licensing/MIT#Standard_ML_of_New_Jersey_Variant
  license "MIT"
  head "https://github.com/onetrueawk/awk.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/awk"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7e467b7aed5f2212dea83a59f27107751d863ab8c20e86e5af5198c28672246b"
  end

  uses_from_macos "bison"

  conflicts_with "gawk", because: "both install an `awk` executable"

  def install
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install "a.out" => "awk"
    man1.install "awk.1"
  end

  test do
    assert_match "test", pipe_output("#{bin}/awk '{print $1}'", "test")
  end
end
