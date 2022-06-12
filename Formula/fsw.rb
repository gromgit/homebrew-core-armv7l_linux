class Fsw < Formula
  desc "File change monitor with multiple backends"
  homepage "https://emcrisostomo.github.io/fsw/"
  url "https://github.com/emcrisostomo/fsw/releases/download/1.3.9/fsw-1.3.9.tar.gz"
  sha256 "9222f76f99ef9841dc937a8f23b529f635ad70b0f004b9dd4afb35c1b0d8f0ff"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fsw"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "140adc34d2170d7d52d3feb950e25be160e87a192005cfdb6a6c91cbf718f32b"
  end

  def install
    ENV.append "CXXFLAGS", "-stdlib=libc++" if OS.mac?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    io = IO.popen("#{bin}/fsw test")
    (testpath/"test").write("foo")
    sleep 2
    rm testpath/"test"
    sleep 2
    (testpath/"test").write("foo")
    sleep 2
    assert_equal File.expand_path("test"), io.gets.strip
  ensure
    Process.kill "INT", io.pid
    Process.wait io.pid
  end
end
