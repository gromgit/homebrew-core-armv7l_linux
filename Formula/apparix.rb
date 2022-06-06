class Apparix < Formula
  desc "File system navigation via bookmarking directories"
  homepage "https://micans.org/apparix/"
  url "https://micans.org/apparix/src/apparix-11-062.tar.gz"
  sha256 "211bb5f67b32ba7c3e044a13e4e79eb998ca017538e9f4b06bc92d5953615235"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/apparix"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f38bdd0005847ae57b379ff7787c7a80e68de768f5cf30542ecb05ec0be5c10f"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    mkdir "test"
    system "#{bin}/apparix", "--add-mark", "homebrew", "test"
    assert_equal "j,homebrew,test",
      shell_output("#{bin}/apparix -lm homebrew").chomp
  end
end
