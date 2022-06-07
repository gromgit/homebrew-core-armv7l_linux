class Colfer < Formula
  desc "Schema compiler for binary data exchange"
  homepage "https://github.com/pascaldekloe/colfer"
  url "https://github.com/pascaldekloe/colfer/archive/v1.8.1.tar.gz"
  sha256 "5d184c8a311543f26c957fff6cad3908b9b0a4d31e454bb7f254b300d004dca7"
  license "CC0-1.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/colfer"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "4cb8156f4d88822c5a3219323f3d528f1042f5f2fa3bd49633aa0d2c64271ec7"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"colf"), "./cmd/colf"
  end

  test do
    (testpath/"try.colf").write <<~EOS
      // Package try is an integration test.
      package try

      // O is an arbitrary data structure.
      type O struct {
        S text
      }
    EOS
    system bin/"colf", "C", testpath/"try.colf"
    system ENV.cc, "-c", "Colfer.c"
  end
end
