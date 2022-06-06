class Aescrypt < Formula
  desc "Program for encryption/decryption"
  homepage "https://aescrypt.sourceforge.io/"
  url "https://aescrypt.sourceforge.io/aescrypt-0.7.tar.gz"
  sha256 "7b17656cbbd76700d313a1c36824a197dfb776cadcbf3a748da5ee3d0791b92d"
  license "BSD-4-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?aescrypt[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/aescrypt"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "14bde5aee6f5a0cab8524228801e48eca830410c81d6eab24b676f62037014ce"
  end

  def install
    system "./configure"
    system "make"
    bin.install "aescrypt", "aesget"
  end

  test do
    (testpath/"key").write "kk=12345678901234567890123456789abc0"
    original_text = "hello"
    cipher_text = pipe_output("#{bin}/aescrypt -k #{testpath}/key -s 128", original_text)
    deciphered_text = pipe_output("#{bin}/aesget -k #{testpath}/key -s 128", cipher_text)
    refute_equal original_text, cipher_text
    assert_equal original_text, deciphered_text
  end
end
