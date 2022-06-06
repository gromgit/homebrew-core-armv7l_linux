class Binkd < Formula
  desc "TCP/IP FTN Mailer"
  homepage "https://2f.ru/binkd/"
  url "https://happy.kiev.ua/pub/fidosoft/mailer/binkd/binkd-1.0.4.tar.gz"
  sha256 "917e45c379bbd1a140d1fe43179a591f1b2ec4004b236d6e0c4680be8f1a0dc0"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/binkd"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "1202a8ceaf7c5c2a47f70bcae76426cf70c54459d45b21fc18e1c03a94604a80"
  end

  uses_from_macos "zlib"

  def install
    cp Dir["mkfls/unix/*"].select { |f| File.file? f }, "."
    inreplace "binkd.conf", "/var/", "#{var}/"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{sbin}/binkd", "-v"
  end
end
