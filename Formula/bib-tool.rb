class BibTool < Formula
  desc "Manipulates BibTeX databases"
  homepage "http://www.gerd-neugebauer.de/software/TeX/BibTool/en/"
  url "https://github.com/ge-ne/bibtool/releases/download/BibTool_2_68/BibTool-2.68.tar.gz"
  sha256 "e1964d199b0726f431f9a1dc4ff7257bb3dba879b9fa221803e0aa7840dee0e0"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bib-tool"
    rebuild 1
    sha256 armv7l_linux: "71718df3d60782be560fbc7457e2b5298a06976d219e58cfda7659b2ab72c5f7"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--without-kpathsea"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.bib").write <<~EOS
      @article{Homebrew,
          title   = {Something},
          author  = {Someone},
          journal = {Something},
          volume  = {1},
          number  = {2},
          pages   = {3--4}
      }
    EOS
    system "#{bin}/bibtool", "test.bib"
  end
end
