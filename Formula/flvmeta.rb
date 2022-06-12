class Flvmeta < Formula
  desc "Manipulate Adobe flash video files (FLV)"
  homepage "https://www.flvmeta.com/"
  url "https://flvmeta.com/files/flvmeta-1.2.2.tar.gz"
  sha256 "a51a2f18d97dfa1d09729546ce9ac690569b4ce6f738a75363113d990c0e5118"
  license "GPL-2.0"
  head "https://github.com/noirotm/flvmeta.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?flvmeta[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/flvmeta"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "e43e96345026e1aee2977b9a7d1a60aaf91dda6ffbbcdcab994b631ae877f94e"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system bin/"flvmeta", "-V"
  end
end
