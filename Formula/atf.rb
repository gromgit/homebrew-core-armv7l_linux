class Atf < Formula
  desc "Automated testing framework"
  homepage "https://github.com/jmmv/atf"
  url "https://github.com/jmmv/atf/releases/download/atf-0.21/atf-0.21.tar.gz"
  sha256 "92bc64180135eea8fe84c91c9f894e678767764f6dbc8482021d4dde09857505"
  license "BSD-2-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/atf"
    rebuild 1
    sha256 armv7l_linux: "b8812a85eeb680c39e22d38de3823afd101521841de9190ae41c76d598d2d8d2"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/890be5f6af88e7913d177af87a50129049e681bb/libtool/configure-pre-0.4.3-big_sur.diff"
    sha256 "58557ebff9e6b8e9b9b71dc6c5820ad3e0c550a385d4126c6078caa2b72e63c1"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    (testpath/"test.sh").write <<~EOS
      #!/usr/bin/env atf-sh
      echo test
      exit 0
    EOS
    system "bash", "test.sh"
  end
end
