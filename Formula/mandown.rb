class Mandown < Formula
  desc "Man-page inspired Markdown viewer"
  homepage "https://github.com/Titor8115/mandown"
  url "https://github.com/Titor8115/mandown/archive/v1.0.1.tar.gz"
  sha256 "b014a44b27f921c12505ba4d8dba15487ca2b442764da645cd6d0fd607ef068c"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mandown"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "726ce5a300713d1c403b9433bc87b08398cf541832604ce64f3cab96b05b56fd"
  end

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"

  def install
    ENV.append "CPPFLAGS", "-I#{Formula["libxml2"].opt_include}/libxml2" unless OS.mac?
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.md").write <<~EOS
      #Hi from readme file!
    EOS
    expected_output = <<~EOS
      <title >test.md(7)</title>
      <h1>Hi from readme file!</h1>
    EOS
    system "#{bin}/mdn", "-f", "test.md", "-o", "test"
    assert_equal expected_output, File.read("test")
  end
end
