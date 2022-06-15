class Pgformatter < Formula
  desc "PostgreSQL syntax beautifier"
  homepage "https://sqlformat.darold.net/"
  url "https://github.com/darold/pgFormatter/archive/v5.2.tar.gz"
  sha256 "78bfc77f54f33d948f9b2e2cd061ceee0b970e263a403603635cfec61e955ae0"
  license "PostgreSQL"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pgformatter"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "fd99a75f6965e3aef08c78a09fd5d3e72d4cd1d815a2ee0c2ad22c78c63a5a56"
  end

  def install
    system "perl", "Makefile.PL", "DESTDIR=."
    system "make", "install"

    if OS.linux?
      # Move man pages to share directory so they will be linked correctly on Linux
      mkdir "usr/local/share"
      mv "usr/local/man", "usr/local/share"
    end

    prefix.install (buildpath/"usr/local").children
    (libexec/"lib").install "blib/lib/pgFormatter"
    libexec.install bin/"pg_format"
    bin.install_symlink libexec/"pg_format"
  end

  test do
    test_file = (testpath/"test.sql")
    test_file.write("SELECT * FROM foo")
    system "#{bin}/pg_format", test_file
  end
end
