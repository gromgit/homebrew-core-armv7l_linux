class Run < Formula
  desc "Easily manage and invoke small scripts and wrappers"
  homepage "https://github.com/TekWizely/run"
  url "https://github.com/TekWizely/run/archive/v0.8.0.tar.gz"
  sha256 "60b4f20152be20f0d7b76adb98ac49eff5f283d9e748165508fd54b62603bb1e"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/run"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "45e09a74c1df632822f70060874d75f092261f150e181c758e580aa0da0ca7e3"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-ldflags", "-w -s", "-o", bin/name
  end

  test do
    text = "Hello Homebrew!"
    task = "hello"
    (testpath/"Runfile").write <<~EOS
      #{task}:
        echo #{text}
    EOS
    assert_equal text, shell_output("#{bin}/#{name} #{task}").chomp
  end
end
