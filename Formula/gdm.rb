require "language/go"

class Gdm < Formula
  desc "Go Dependency Manager (gdm)"
  homepage "https://github.com/sparrc/gdm"
  url "https://github.com/sparrc/gdm/archive/1.4.tar.gz"
  sha256 "2ac8800319d922fe2816e57f30e23ddd9a11ce2e93294c533318b9f081debde4"
  license "Unlicense"
  head "https://github.com/sparrc/gdm.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gdm"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "f1555748452322b8463a867f4de29d639b219a583beff6fa9a07bd924ebda35e"
  end

  depends_on "go"

  go_resource "golang.org/x/tools" do
    url "https://go.googlesource.com/tools.git",
        revision: "6f233b96dfbc53e33b302e31b88814cf74697ff6"
  end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    mkdir_p buildpath/"src/github.com/sparrc"
    ln_sf buildpath, buildpath/"src/github.com/sparrc/gdm"

    Language::Go.stage_deps resources, buildpath/"src"

    cd "src/github.com/sparrc/gdm" do
      system "go", "build", "-o", bin/"gdm",
             "-ldflags", "-X main.Version=#{version}"
    end
  end

  test do
    ENV["GOPATH"] = testpath.realpath
    ENV["GO111MODULE"] = "auto"
    assert_match version.to_s, shell_output("#{bin}/gdm version")
    assert_match testpath.realpath.to_s, shell_output("#{bin}/gdm save")
    system bin/"gdm", "restore"
  end
end
