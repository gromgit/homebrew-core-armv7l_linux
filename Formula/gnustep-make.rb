class GnustepMake < Formula
  desc "Basic GNUstep Makefiles"
  homepage "http://gnustep.org"
  url "http://ftpmain.gnustep.org/pub/gnustep/core/gnustep-make-2.9.0.tar.gz"
  sha256 "a0b066c11257879c7c85311dea69c67f6dc741ef339db6514f85b64992c40d2a"
  license "GPL-3.0-or-later"

  livecheck do
    url "http://ftpmain.gnustep.org/pub/gnustep/core/"
    regex(/href=.*?gnustep-make[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gnustep-make"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b00e869de34d703c69d9d7e17487ad9f41c17c5425f7c86f692b450f3c73240f"
  end

  def install
    system "./configure", *std_configure_args,
                          "--with-config-file=#{prefix}/etc/GNUstep.conf",
                          "--enable-native-objc-exceptions"
    system "make", "install", "tooldir=#{libexec}"
  end

  test do
    assert_match shell_output("#{libexec}/gnustep-config --variable=CC").chomp, ENV.cc
  end
end
