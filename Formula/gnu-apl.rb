class GnuApl < Formula
  desc "GNU implementation of the programming language APL"
  homepage "https://www.gnu.org/software/apl/"
  license "GPL-3.0"

  stable do
    url "https://ftp.gnu.org/gnu/apl/apl-1.8.tar.gz"
    mirror "https://ftpmirror.gnu.org/apl/apl-1.8.tar.gz"
    sha256 "144f4c858a0d430ce8f28be90a35920dd8e0951e56976cb80b55053fa0d8bbcb"

    # Fix -flat_namespace being used on Big Sur and later.
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-pre-0.4.2.418-big_sur.diff"
      sha256 "83af02f2aa2b746bb7225872cab29a253264be49db0ecebb12f841562d9a2923"
    end
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gnu-apl"
    sha256 armv7l_linux: "04ed3e1ed84a3e39e8a98505436bced108a33130935f12c3e14b6f10013ed225"
  end

  head do
    url "https://svn.savannah.gnu.org/svn/apl/trunk"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "readline" # GNU Readline is required, libedit won't work

  def install
    # Work around "error: no member named 'signbit' in the global namespace"
    # encountered when trying to detect boost regex in configure
    ENV.delete("SDKROOT") if DevelopmentTools.clang_build_version >= 900
    ENV.delete("HOMEBREW_SDKROOT") if MacOS.version == :high_sierra

    system "autoreconf", "-fiv" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"hello.apl").write <<~EOS
      'Hello world'
      )OFF
    EOS

    pid = fork do
      exec "#{bin}/APserver"
    end
    sleep 4

    begin
      assert_match "Hello world", shell_output("#{bin}/apl -s -f hello.apl")
    ensure
      Process.kill("SIGINT", pid)
      Process.wait(pid)
    end
  end
end
