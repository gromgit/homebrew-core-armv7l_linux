class Lockrun < Formula
  desc "Run cron jobs with overrun protection"
  homepage "http://unixwiz.net/tools/lockrun.html"
  url "http://unixwiz.net/tools/lockrun.c"
  version "1.1.3"
  sha256 "cea2e1e64c57cb3bb9728242c2d30afeb528563e4d75b650e8acae319a2ec547"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/lockrun"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "90d633499e106435c52108b61806d5537c62cd2821bb9e34ad8ab496322faf9d"
  end

  def install
    system ENV.cc, "lockrun.c", "-o", "lockrun"
    bin.install "lockrun"
  end

  test do
    system "#{bin}/lockrun", "--version"
  end
end
