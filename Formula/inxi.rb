class Inxi < Formula
  desc "Full featured CLI system information tool"
  homepage "https://smxi.org/docs/inxi.htm"
  url "https://github.com/smxi/inxi/archive/3.3.13-1.tar.gz"
  sha256 "44d11d88fc0fd2213401436d8e7d09b755ab8af3ca10443d7f4fb32edae92fef"
  license "GPL-3.0-or-later"
  head "https://github.com/smxi/inxi.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/inxi"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "5f053e694fd1909d133773c88d6be1ef03e80d5aa976c5f396a9535ea1877f7b"
  end

  uses_from_macos "perl"

  def install
    bin.install "inxi"
    man1.install "inxi.1"

    ["LICENSE.txt", "README.txt", "inxi.changelog"].each do |file|
      prefix.install file
    end
  end

  test do
    inxi_output = shell_output("#{bin}/inxi")

    # This test does not work on Linux, because on that platform
    # inxi does not print the OS name, only the kernel version.
    if OS.mac?
      uname = shell_output("uname").strip
      assert_match uname.to_str, inxi_output.to_s
    end

    uname_r = shell_output("uname -r").strip
    assert_match uname_r.to_str, inxi_output.to_s
  end
end
