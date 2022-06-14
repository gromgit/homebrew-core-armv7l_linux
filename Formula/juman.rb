class Juman < Formula
  desc "Japanese morphological analysis system"
  homepage "https://nlp.ist.i.kyoto-u.ac.jp/index.php?JUMAN"
  url "https://nlp.ist.i.kyoto-u.ac.jp/nl-resource/juman/juman-7.01.tar.bz2"
  sha256 "64bee311de19e6d9577d007bb55281e44299972637bd8a2a8bc2efbad2f917c6"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/juman"
    sha256 armv7l_linux: "2bb74b66bd451e3774a77ea9167fd886777497a46899712b6364623574e621f1"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-pre-0.4.2.418-big_sur.diff"
    sha256 "83af02f2aa2b746bb7225872cab29a253264be49db0ecebb12f841562d9a2923"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    md5 = OS.mac? ? "md5" : "md5sum"
    result = pipe_output(md5, pipe_output(bin/"juman", "\xe4\xba\xac\xe9\x83\xbd\xe5\xa4\xa7\xe5\xad\xa6"))
    assert_equal "a5dd58c8ffa618649c5791f67149ab56", result.chomp.split.first
  end
end
