class Odo < Formula
  desc "Atomic odometer for the command-line"
  homepage "https://github.com/atomicobject/odo"
  url "https://github.com/atomicobject/odo/archive/v0.2.2.tar.gz"
  sha256 "52133a6b92510d27dfe80c7e9f333b90af43d12f7ea0cf00718aee8a85824df5"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/odo"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1a9498a970c110dc9c99f2f9b41f8142e8e8244c97db5e43d1cc8de6d4765d67"
  end

  conflicts_with "odo-dev", because: "odo-dev also ships 'odo' binary"

  def install
    system "make"
    man1.mkpath
    bin.mkpath
    system "make", "test"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/odo", "testlog"
  end
end
