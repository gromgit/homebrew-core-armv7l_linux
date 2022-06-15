class Netcat6 < Formula
  desc "Rewrite of netcat that supports IPv6, plus other improvements"
  homepage "https://www.deepspace6.net/projects/netcat6.html"
  url "https://deb.debian.org/debian/pool/main/n/nc6/nc6_1.0.orig.tar.gz"
  sha256 "db7462839dd135ff1215911157b666df8512df6f7343a075b2f9a2ef46fe5412"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/netcat6"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ce6e8e42e742b4ca0c967abd6bbf672761bb35c57725c0cad8b416ab835b69a9"
  end

  # Upstream appears to have stopped developing netcat6 and instead recommends
  # using OpenBSD's netcat (which supports IPv6) or Nmap's netcat replacement
  # (ncat).
  deprecate! date: "2021-03-27", because: :deprecated_upstream

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    out = pipe_output("#{bin}/nc6 www.google.com 80", "GET / HTTP/1.0\r\n\r\n")
    assert_equal "HTTP/1.0 200 OK", out.lines.first.chomp
  end
end
