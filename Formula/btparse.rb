class Btparse < Formula
  desc "BibTeX utility libraries"
  homepage "https://metacpan.org/pod/distribution/Text-BibTeX/btparse/doc/btparse.pod"
  url "https://cpan.metacpan.org/authors/id/A/AM/AMBS/btparse/btparse-0.35.tar.gz"
  sha256 "631bf1b79dfd4c83377b416a12c349fe88ee37448dc82e41424b2f364a99477b"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/btparse"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1f2f15a84553758502b962bac49982e1c349e4cbac9f5e4a4570b4d8fedcca05"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    (testpath/"test.bib").write <<~EOS
      @article{mxcl09,
        title={{H}omebrew},
        author={{H}owell, {M}ax},
        journal={GitHub},
        volume={1},
        page={42},
        year={2009}
      }
    EOS

    system "#{bin}/bibparse", "-check", "test.bib"
  end
end
