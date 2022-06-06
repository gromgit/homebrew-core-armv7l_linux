class Atasm < Formula
  desc "Atari MAC/65 compatible assembler for Unix"
  homepage "https://atari.miribilist.com/atasm/"
  url "https://atari.miribilist.com/atasm/atasm109.zip"
  version "1.09"
  sha256 "dbab21870dabdf419920fcfa4b5adfe9d38b291a60a4bc2ba824595f7fbc3ef0"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://atari.miribilist.com/atasm/VERSION.TXT"
    regex(/  version (\d+(?:\.\d+)+) /i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/atasm"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7b4a042b739365d7a1085c35adb8882d7a39c8e82fa4a119caf1de75a5cd352f"
  end

  uses_from_macos "zlib"

  def install
    cd "src" do
      system "make"
      bin.install "atasm"
      inreplace "atasm.1.in", "%%DOCDIR%%", "#{HOMEBREW_PREFIX}/share/doc/atasm"
      man1.install "atasm.1.in" => "atasm.1"
    end
    doc.install "examples", Dir["docs/atasm.*"]
  end

  test do
    cd "#{doc}/examples" do
      system "#{bin}/atasm", "-v", "test.m65", "-o/tmp/test.bin"
    end
  end
end
