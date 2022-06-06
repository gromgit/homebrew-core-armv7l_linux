class Bsdconv < Formula
  desc "Charset/encoding converter library"
  homepage "https://github.com/buganini/bsdconv"
  url "https://github.com/buganini/bsdconv/archive/11.6.tar.gz"
  sha256 "e856e24474deb3731ac059a96af0078ba951895f2cb3b31f125148a29cc32b70"
  license "BSD-2-Clause"
  head "https://github.com/buganini/bsdconv.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/bsdconv"
    rebuild 1
    sha256 armv7l_linux: "6129c8efc88322babad3e27051d21538a2f50ad1a3c40e0cbe67073646d18b51"
  end

  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    output = pipe_output("#{bin}/bsdconv BIG5:UTF-8", "\263\134\273\134")
    output.force_encoding("UTF-8") if output.respond_to?(:force_encoding)
    assert_equal "許蓋", output
  end
end
