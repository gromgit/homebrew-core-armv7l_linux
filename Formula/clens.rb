class Clens < Formula
  desc "Library to help port code from OpenBSD to other operating systems"
  homepage "https://github.com/conformal/clens"
  url "https://github.com/conformal/clens/archive/CLENS_0_7_0.tar.gz"
  sha256 "0cc18155c2c98077cb90f07f6ad8334314606c4be0b6ffc13d6996171c7dc09d"
  license "ISC"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/clens"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "48c9f26925e99325f54a22a5b93e833e31791a1c93e5029275c5ee861100283d"
  end

  on_linux do
    depends_on "libbsd"
  end

  patch do
    url "https://github.com/conformal/clens/commit/83648cc9027d9f76a1bc79ddddcbed1349b9d5cd.patch?full_index=1"
    sha256 "c70833eff6f98eab6166e9c341bb444eae542617f4937a29514fe5c6bbd3d8b0"
  end

  def install
    ENV.deparallelize
    system "make", "all", "install", "LOCALBASE=#{prefix}"
  end
end
