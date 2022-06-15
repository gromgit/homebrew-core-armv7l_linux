class Nutcracker < Formula
  desc "Proxy for memcached and redis"
  homepage "https://github.com/twitter/twemproxy"
  url "https://github.com/twitter/twemproxy/archive/0.5.0.tar.gz"
  sha256 "73f305d8525abbaaa6a5f203c1fba438f99319711bfcb2bb8b2f06f0d63d1633"
  license "Apache-2.0"
  revision 1
  head "https://github.com/twitter/twemproxy.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/nutcracker"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "beb2e46f7288a7a2bc59fa939300e8b12d10e25b8a80063e24a1983a0cd28ce6"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libyaml"

  # Use Homebrew libyaml instead of the vendored one.
  # Adapted from Debian's equivalent patch.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/0e1ac7ef20e83159554b6522380b1c4b48ce4f2f/nutcracker/use-system-libyaml.patch"
    sha256 "9105f2bd784f291da5c3f3fb4f6876e62ab7a6f78256f81f5574d593924e424c"
  end

  def install
    system "autoreconf", "-ivf"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"

    pkgshare.install "conf", "notes", "scripts"
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/nutcracker -V 2>&1")
  end
end
