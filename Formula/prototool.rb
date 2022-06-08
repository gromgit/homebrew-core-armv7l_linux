class Prototool < Formula
  desc "Your Swiss Army Knife for Protocol Buffers"
  homepage "https://github.com/uber/prototool"
  url "https://github.com/uber/prototool/archive/v1.10.0.tar.gz"
  sha256 "5b516418f41f7283a405bf4a8feb2c7034d9f3d8c292b2caaebcd218581d2de4"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/prototool"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "37275151e00937ca401627a35355cc3833bfd5be9d92733ce4110a24e9c339d5"
  end

  depends_on "go" => :build

  def install
    system "make", "brewgen"
    cd "brew" do
      bin.install "bin/prototool"
      bash_completion.install "etc/bash_completion.d/prototool"
      zsh_completion.install "etc/zsh/site-functions/_prototool"
      man1.install Dir["share/man/man1/*.1"]
      prefix.install_metafiles
    end
  end

  test do
    system bin/"prototool", "config", "init"
    assert_predicate testpath/"prototool.yaml", :exist?
  end
end
