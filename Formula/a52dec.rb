class A52dec < Formula
  desc "Library for decoding ATSC A/52 streams (AKA 'AC-3')"
  homepage "https://liba52.sourceforge.io/"
  url "https://liba52.sourceforge.io/files/a52dec-0.7.4.tar.gz"
  sha256 "a21d724ab3b3933330194353687df82c475b5dfb997513eef4c25de6c865ec33"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://liba52.sourceforge.io/downloads.html"
    regex(/href=.*?a52dec[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/a52dec"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "4c8bc2fb8115a5cda3fc7f5676af39e05f7afe6522982f090ff97b845620355b"
  end

  def install
    if OS.linux?
      # Fix error ld: imdct.lo: relocation R_X86_64_32 against `.bss' can not be
      # used when making a shared object; recompile with -fPIC
      ENV.append_to_cflags "-fPIC"
    else
      # Fixes duplicate symbols errors on arm64
      ENV.append_to_cflags "-std=gnu89"
    end

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-shared",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    touch testpath/"test"
    system "#{bin}/a52dec", "-o", "null", "test"
  end
end
