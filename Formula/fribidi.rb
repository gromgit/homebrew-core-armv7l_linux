class Fribidi < Formula
  desc "Implementation of the Unicode BiDi algorithm"
  homepage "https://github.com/fribidi/fribidi"
  url "https://github.com/fribidi/fribidi/releases/download/v1.0.12/fribidi-1.0.12.tar.xz"
  sha256 "0cd233f97fc8c67bb3ac27ce8440def5d3ffacf516765b91c2cc654498293495"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fribidi"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "6375f92ebd674b7bb3e5f494ad4179a5cb6aedbbda0d424b28c72a3b4ec60f7a"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-static"
    system "make", "install"
  end

  test do
    (testpath/"test.input").write <<~EOS
      a _lsimple _RteST_o th_oat
    EOS

    assert_match "a simple TSet that", shell_output("#{bin}/fribidi --charset=CapRTL --test test.input")
  end
end
