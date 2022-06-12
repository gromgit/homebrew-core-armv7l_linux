class Duff < Formula
  desc "Quickly find duplicates in a set of files from the command-line"
  homepage "https://duff.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/duff/duff/0.5.2/duff-0.5.2.tar.gz"
  sha256 "15b721f7e0ea43eba3fd6afb41dbd1be63c678952bf3d80350130a0e710c542e"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/duff"
    sha256 armv7l_linux: "9766aef08da0cc5992b9dbfd88abd4421bc7639b43db0894a9fdfd0e5a11e92f"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    expected = <<~EOS
      2 files in cluster 1 (6 bytes, digest 8843d7f92416211de9ebb963ff4ce28125932878)
      cmp1
      cmp2
    EOS

    (testpath/"cmp1").write "foobar"
    (testpath/"cmp2").write "foobar"

    assert_equal expected, shell_output("#{bin}/duff cmp1 cmp2")
  end
end
