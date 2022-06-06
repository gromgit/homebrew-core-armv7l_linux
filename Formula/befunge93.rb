class Befunge93 < Formula
  desc "Esoteric programming language"
  homepage "https://catseye.tc/article/Languages.md#befunge-93"
  url "https://catseye.tc/distfiles/befunge-93-2.25.zip"
  version "2.25"
  sha256 "93a11fbc98d559f2bf9d862b9ffd2932cbe7193236036169812eb8e72fd69b19"
  license "BSD-3-Clause"
  head "https://github.com/catseye/Befunge-93.git", branch: "master"

  livecheck do
    url "https://catseye.tc/distribution/Befunge-93_distribution"
    regex(/href=.*?befunge-93[._-]v?(\d+(?:\.\d+)+)\.zip/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/befunge93"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "5f0801fa82ea4270cad39f9640e99429edde3d9b984078e71452ec72a7ec23d3"
  end

  def install
    system "make"
    bin.install Dir["bin/bef*"]
  end

  test do
    (testpath/"test.bf").write '"dlroW olleH" ,,,,,,,,,,, @'
    assert_match "Hello World", shell_output("#{bin}/bef test.bf")
  end
end
