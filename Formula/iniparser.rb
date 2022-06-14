class Iniparser < Formula
  desc "Library for parsing ini files"
  homepage "http://ndevilla.free.fr/iniparser/"
  url "https://github.com/ndevilla/iniparser/archive/v4.1.tar.gz"
  sha256 "960daa800dd31d70ba1bacf3ea2d22e8ddfc2906534bf328319495966443f3ae"
  license "MIT"
  head "https://github.com/ndevilla/iniparser.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/iniparser"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "4639c70761b0a46250926e300b9267fbefc48f4cf6c77137b5b442cff60baa6a"
  end

  conflicts_with "fastbit", because: "both install `include/dictionary.h`"

  def install
    # Only make the *.a file; the *.so target is useless (and fails).
    system "make", "libiniparser.a", "CC=#{ENV.cc}", "RANLIB=ranlib"
    lib.install "libiniparser.a"
    include.install Dir["src/*.h"]
  end
end
