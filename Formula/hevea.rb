class Hevea < Formula
  desc "LaTeX-to-HTML translator"
  homepage "http://hevea.inria.fr/"
  url "http://hevea.inria.fr/old/hevea-2.35.tar.gz"
  sha256 "f189bada5d3e5b35855dfdfdb5b270c994fc7a2366b01250d761359ad66c9ecb"

  livecheck do
    url "http://hevea.inria.fr/old/"
    regex(/href=.*?hevea[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/hevea"
    sha256 armv7l_linux: "358aaef815675e8d326ab4cb799efa2a3cafc72d1d7cbbfe50303c85310822a3"
  end

  depends_on "ocamlbuild" => :build
  depends_on "ocaml"

  def install
    ENV["PREFIX"] = prefix
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.tex").write <<~EOS
      \\documentclass{article}
      \\begin{document}
      \\end{document}
    EOS
    system "#{bin}/hevea", "test.tex"
  end
end
