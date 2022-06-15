class Nzbget < Formula
  desc "Binary newsgrabber for nzb files"
  homepage "https://nzbget.net/"
  url "https://github.com/nzbget/nzbget/releases/download/v21.1/nzbget-21.1-src.tar.gz"
  sha256 "4e8fc1beb80dc2af2d6a36a33a33f44dedddd4486002c644f4c4793043072025"
  license "GPL-2.0-or-later"
  head "https://github.com/nzbget/nzbget.git", branch: "develop"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/nzbget"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "142f5bffb5e1b2b15e8586c1ae45ec6d4cd1e3069b60d1bdfe5427e9ebc66bda"
  end

  depends_on "pkg-config" => :build
  depends_on "openssl@1.1"

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"

  def install
    ENV.cxx11

    # Fix "ncurses library not found"
    # Reported 14 Aug 2016: https://github.com/nzbget/nzbget/issues/264
    if OS.mac?
      (buildpath/"brew_include").install_symlink MacOS.sdk_path/"usr/include/ncurses.h"
      ENV["ncurses_CFLAGS"] = "-I#{buildpath}/brew_include"
      ENV["ncurses_LIBS"] = "-L/usr/lib -lncurses"
    else
      ENV["ncurses_CFLAGS"] = "-I#{Formula["ncurses"].opt_include}"
      ENV["ncurses_LIBS"] = "-L#{Formula["ncurses"].opt_lib} -lncurses"
    end

    # Tell configure to use OpenSSL
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-tlslib=OpenSSL"
    system "make"
    ENV.deparallelize
    system "make", "install"
    pkgshare.install_symlink "nzbget.conf" => "webui/nzbget.conf"

    # Set upstream's recommended values for file systems without
    # sparse-file support (e.g., HFS+); see Homebrew/homebrew-core#972
    if OS.mac?
      inreplace "nzbget.conf", "DirectWrite=yes", "DirectWrite=no"
      inreplace "nzbget.conf", "ArticleCache=0", "ArticleCache=700"
    end

    etc.install "nzbget.conf"
  end

  service do
    run [opt_bin/"nzbget", "-c", HOMEBREW_PREFIX/"etc/nzbget.conf", "-s", "-o", "OutputMode=Log",
         "-o", "ConfigTemplate=#{HOMEBREW_PREFIX}/opt/nzbget/share/nzbget/nzbget.conf",
         "-o", "WebDir=#{HOMEBREW_PREFIX}/opt/nzbget/share/nzbget/webui"]
    keep_alive true
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  end

  test do
    (testpath/"downloads/dst").mkpath
    # Start nzbget as a server in daemon-mode
    system "#{bin}/nzbget", "-D", "-c", etc/"nzbget.conf"
    # Query server for version information
    system "#{bin}/nzbget", "-V", "-c", etc/"nzbget.conf"
    # Shutdown server daemon
    system "#{bin}/nzbget", "-Q", "-c", etc/"nzbget.conf"
  end
end
