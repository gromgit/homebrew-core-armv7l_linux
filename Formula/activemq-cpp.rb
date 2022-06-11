class ActivemqCpp < Formula
  desc "C++ API for message brokers such as Apache ActiveMQ"
  homepage "https://activemq.apache.org/components/cms/"
  url "https://www.apache.org/dyn/closer.lua?path=activemq/activemq-cpp/3.9.5/activemq-cpp-library-3.9.5-src.tar.bz2"
  mirror "https://archive.apache.org/dist/activemq/activemq-cpp/3.9.5/activemq-cpp-library-3.9.5-src.tar.bz2"
  sha256 "6bd794818ae5b5567dbdaeb30f0508cc7d03808a4b04e0d24695b2501ba70c15"
  license "Apache-2.0"
  revision 1

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/activemq-cpp"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3d3b567c234525599968ed125f52a46cb8b85deee62074d867f02b739d3a9713"
  end

  depends_on "pkg-config" => :build
  depends_on "apr"
  depends_on "openssl@1.1"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/activemqcpp-config", "--version"
  end
end
