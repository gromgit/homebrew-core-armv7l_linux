class Qpdf < Formula
  desc "Tools for and transforming and inspecting PDF files"
  homepage "https://github.com/qpdf/qpdf"
  url "https://github.com/qpdf/qpdf/releases/download/release-qpdf-10.6.3/qpdf-10.6.3.tar.gz"
  sha256 "e8fc23b2a584ea68c963a897515d3eb3129186741dd19d13c86d31fa33493811"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^release-qpdf[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/qpdf"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "331d31677f4c2fe8f0476c26c6d69657bca33d37a69d35cdcfdf930a751cbc55"
  end

  depends_on "jpeg"
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/qpdf", "--version"
  end
end
