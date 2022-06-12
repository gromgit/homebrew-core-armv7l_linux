class Foremost < Formula
  desc "Console program to recover files based on their headers and footers"
  homepage "https://foremost.sourceforge.io/"
  url "https://foremost.sourceforge.io/pkg/foremost-1.5.7.tar.gz"
  sha256 "502054ef212e3d90b292e99c7f7ac91f89f024720cd5a7e7680c3d1901ef5f34"
  license :public_domain
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?foremost[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/foremost"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "b888137a7d852998b0a98980d718a9ac94c82608d45aa86b9ff27d3955b917e6"
  end

  def install
    inreplace "Makefile" do |s|
      s.gsub! "/usr/", "#{prefix}/"
      s.change_make_var! "RAW_CC", ENV.cc
      s.gsub!(/^RAW_FLAGS =/, "RAW_FLAGS = #{ENV.cflags}")
    end

    # Startup the command tries to look for the default config file in /usr/local,
    # move it to etc instead
    inreplace "config.c", "/usr/local/etc/", "#{etc}/"

    if OS.mac?
      system "make", "mac"
    else
      system "make"
    end

    bin.install "foremost"
    man8.install "foremost.8.gz"
    etc.install "foremost.conf" => "foremost.conf.default"
  end

  test do
    system "#{bin}/foremost", "-V"
  end
end
