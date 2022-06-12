class Fsh < Formula
  desc "Provides remote command execution"
  homepage "https://www.lysator.liu.se/fsh/"
  url "https://www.lysator.liu.se/fsh/fsh-1.2.tar.gz"
  sha256 "9600882648966272c264cf3f1c41c11c91e704f473af43d8d4e0ac5850298826"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/fsh"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3cbdc1d80bdd22165c3f896eff5a539b609556fa61deb26bdc1afd76c9204ddf"
  end

  # Requires Python 2.
  # https://github.com/Homebrew/homebrew-core/issues/93940
  deprecate! date: "2022-03-10", because: :unsupported

  def install
    # FCNTL was deprecated and needs to be changed to fcntl
    inreplace "fshcompat.py", "FCNTL", "fcntl"

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--infodir=#{info}"
    system "make", "install"
  end

  test do
    system "#{bin}/fsh", "-V"
  end
end
