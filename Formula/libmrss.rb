class Libmrss < Formula
  desc "C library for RSS files or streams"
  homepage "https://github.com/bakulf/libmrss"
  # Update to use an archive from GitHub once there's a release after 0.19.2
  url "https://www.autistici.org/bakunin/libmrss/libmrss-0.19.2.tar.gz"
  sha256 "071416adcae5c1a9317a4a313f2deb34667e3cc2be4487fb3076528ce45b210b"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/libmrss"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e0b7eb4c7805057ad3e8577b54b9eb0dc8294eaa2fb25d98b9fffd874ee47dd7"
  end

  head do
    url "https://github.com/bakulf/libmrss.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libnxml"

  on_macos do
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    if build.head?
      mkdir "m4"
      inreplace "autogen.sh", "libtoolize", "glibtoolize"
      system "./autogen.sh"
    elsif OS.mac?
      system "autoreconf", "--force", "--verbose", "--install"
    end

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
