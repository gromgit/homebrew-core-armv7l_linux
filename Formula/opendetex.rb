class Opendetex < Formula
  desc "Tool to strip TeX or LaTeX commands from documents"
  homepage "https://github.com/pkubowicz/opendetex"
  url "https://github.com/pkubowicz/opendetex/releases/download/v2.8.9/opendetex-2.8.9.tar.bz2"
  sha256 "0d6b8cb1f3394b790dd757b0171ad8b398c48e306fa6339e86ed8303c51df084"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/opendetex"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ae63ba7b30ea7ff5cfe3c3970091acef3e1c1ce6407bce6fe0a6099b8064c914"
  end

  uses_from_macos "flex" => :build

  def install
    system "make"
    bin.install "detex"
    bin.install "delatex"
    man1.install "detex.1"
  end

  test do
    (testpath/"test.tex").write <<~EOS
      \\documentclass{article}
      \\begin{document}
      Simple \\emph{text}.
      \\end{document}
    EOS

    output = shell_output("#{bin}/detex test.tex")
    assert_equal "Simple text.\n", output
  end
end
