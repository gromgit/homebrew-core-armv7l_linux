class B43Fwcutter < Formula
  desc "Extract firmware from Braodcom 43xx driver files"
  homepage "https://wireless.wiki.kernel.org/en/users/drivers/b43"
  url "https://bues.ch/b43/fwcutter/b43-fwcutter-019.tar.bz2"
  mirror "https://launchpad.net/ubuntu/+archive/primary/+files/b43-fwcutter_019.orig.tar.bz2"
  sha256 "d6ea85310df6ae08e7f7e46d8b975e17fc867145ee249307413cfbe15d7121ce"
  license "BSD-2-Clause"

  livecheck do
    url "https://bues.ch/b43/fwcutter/"
    regex(/href=.*?b43-fwcutter[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/b43-fwcutter"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "d195797e8f00ef9dc6d7d26092291bbcf1e117d12e99c827f85c0c306fffc3b4"
  end

  def install
    inreplace "Makefile" do |m|
      # Don't try to chown root:root on generated files
      m.gsub! "install -o 0 -g 0", "install"
      m.gsub! "install -d -o 0 -g 0", "install -d"
      # Fix manpage installation directory
      m.gsub! "$(PREFIX)/man", man
    end
    # b43-fwcutter has no ./configure
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "#{bin}/b43-fwcutter", "--version"
  end
end
