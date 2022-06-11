class Cmockery < Formula
  desc "Unit testing and mocking library for C"
  homepage "https://github.com/google/cmockery"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/cmockery/cmockery-0.1.2.tar.gz"
  sha256 "b9e04bfbeb45ceee9b6107aa5db671c53683a992082ed2828295e83dc84a8486"
  # Installed COPYING is BSD-3-Clause but source code uses Apache-2.0.
  # TODO: Change license to Apache-2.0 on next version as COPYING was replaced by LICENSE.txt
  license all_of: ["BSD-3-Clause", "Apache-2.0"]

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/cmockery"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "7e62e0a84c7f11557042a7558d79c912382a38807c042e6d7a5e33061c8e2884"
  end

  on_macos do
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  # This patch will be integrated upstream in 0.1.3, this is due to malloc.h being already in stdlib on OSX
  # It is safe to remove it on the next version
  # More info on https://code.google.com/p/cmockery/issues/detail?id=3
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/85fa66a9/cmockery/0.1.2.patch"
    sha256 "4e1ba6ac1ee11350b7608b1ecd777c6b491d952538bc1b92d4ed407669ec712d"
  end

  def install
    # Fix -flat_namespace being used on Big Sur and later.
    # Need to regenerate configure since existing patches don't apply.
    system "autoreconf", "--force", "--install", "--verbose" if OS.mac?

    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
