class Massdns < Formula
  desc "High-performance DNS stub resolver"
  homepage "https://github.com/blechschmidt/massdns"
  url "https://github.com/blechschmidt/massdns/archive/v1.0.0.tar.gz"
  sha256 "0eba00a03e74a02a78628819741c75c2832fb94223d0ff632249f2cc55d0fdbb"
  license "GPL-3.0-only"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/massdns"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "cb3f1b7dc878f0f6e9c6a51b565d1992a5d6702e6623ec2ca7fe2af0f3488b7e"
  end

  depends_on "cmake" => :build

  def install
    ENV.cxx11

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
    end

    bin.install "build/bin/massdns"
    etc.install Dir["lists", "scripts"]
  end

  test do
    cp_r etc/"lists/resolvers.txt", testpath
    (testpath/"domains.txt").write "docs.brew.sh"
    system bin/"massdns", "-r", testpath/"resolvers.txt", "-t", "AAAA", "-w", "results.txt", testpath/"domains.txt"

    assert_match ";; ->>HEADER<<- opcode: QUERY, status: NOERROR, id:", File.read("results.txt")
    assert_match "IN CNAME homebrew.github.io.", File.read("results.txt")
  end
end
