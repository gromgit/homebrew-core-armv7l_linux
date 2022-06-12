class Hiredis < Formula
  desc "Minimalistic client for Redis"
  homepage "https://github.com/redis/hiredis"
  url "https://github.com/redis/hiredis/archive/v1.0.2.tar.gz"
  sha256 "e0ab696e2f07deb4252dda45b703d09854e53b9703c7d52182ce5a22616c3819"
  license "BSD-3-Clause"
  head "https://github.com/redis/hiredis.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/hiredis"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3dce62a2ff4c6126a0ad53a7146e28c81d6116a80da280541dcf09a63e039550"
  end

  # remove in next release
  patch do
    url "https://github.com/redis/hiredis/commit/8d86cb4.patch?full_index=1"
    sha256 "2f1b20defbd882c220e2c2d88da8dae970b7fbd6445363303b2ae7b75263f0ff"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
    pkgshare.install "examples"
  end

  test do
    # running `./test` requires a database to connect to, so just make
    # sure it compiles
    system ENV.cc, pkgshare/"examples/example.c", "-o", testpath/"test",
                   "-I#{include}/hiredis", "-L#{lib}", "-lhiredis"
    assert_predicate testpath/"test", :exist?
  end
end
