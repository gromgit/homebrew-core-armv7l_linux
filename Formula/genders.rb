class Genders < Formula
  desc "Static cluster configuration database for cluster management"
  homepage "https://github.com/chaos/genders"
  url "https://github.com/chaos/genders/archive/genders-1-27-3.tar.gz"
  version "1.27.3"
  sha256 "c176045a7dd125313d44abcb7968ded61826028fe906028a2967442426229894"
  license "GPL-2.0"

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/genders[._-]v?(\d+(?:[.-]\d+)+)["' >]}i)
  end

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/genders"
    rebuild 1
    sha256 cellar: :any_skip_relocation, armv7l_linux: "aab52511f061a48c8160de1c063f3f8afbcd0787965d52132570ff5de28fbb0f"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build
  uses_from_macos "python" => :build

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-pre-0.4.2.418-big_sur.diff"
    sha256 "83af02f2aa2b746bb7225872cab29a253264be49db0ecebb12f841562d9a2923"
  end

  def install
    ENV["PYTHON"] = which("python3")
    system "./configure", "--prefix=#{prefix}", "--with-java-extensions=no"
    system "make", "install"

    # Move man page out of top level mandir on Linux
    man3.install (prefix/"man/man3").children unless OS.mac?
  end

  test do
    (testpath/"cluster").write <<~EOS
      # slc cluster genders file
      slci,slcj,slc[0-15]  eth2=e%n,cluster=slc,all
      slci                 passwdhost
      slci,slcj            management
      slc[1-15]            compute
    EOS
    assert_match "0 parse errors discovered", shell_output("#{bin}/nodeattr -f cluster -k 2>&1")
  end
end
