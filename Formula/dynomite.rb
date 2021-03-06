class Dynomite < Formula
  desc "Generic dynamo implementation for different k-v storage engines"
  homepage "https://github.com/Netflix/dynomite"
  url "https://github.com/Netflix/dynomite/archive/v0.6.22.tar.gz"
  sha256 "9c3c60d95b39939f3ce596776febe8aa00ae8614ba85aa767e74d41e302e704a"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/dynomite"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "c29c02c42f975c1b69b3e3ff8940c857eb3f6f5e2928bd8747cf51c8905d5b18"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "openssl@3"

  def install
    system "autoreconf", "-fvi"
    system "./configure", *std_configure_args,
                          "--disable-silent-rules"
    system "make"
    system "make", "install"
    (etc/"dynomite").install Dir["conf/*"]
  end

  test do
    stats_port = free_port

    cp etc/"dynomite/redis_single.yml", testpath
    inreplace "redis_single.yml" do |s|
      s.gsub! ":8102", ":#{free_port}"
      s.gsub! ":8101", ":#{free_port}"
      s.gsub! ":22122", ":#{free_port}"
      s.gsub! ":22222", ":#{stats_port}"
    end

    fork { exec sbin/"dynomite", "-c", "redis_single.yml" }
    sleep 1
    assert_match "OK", shell_output("curl -s 127.0.0.1:#{stats_port}")
  end
end
