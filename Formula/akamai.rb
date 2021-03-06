class Akamai < Formula
  desc "CLI toolkit for working with Akamai's APIs"
  homepage "https://github.com/akamai/cli"
  url "https://github.com/akamai/cli/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "41687c6d4945094a9837dd2966bdd374d8265062d8547235d1c5a136dd08f79e"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/akamai"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "3c90aa65fa374c96d792ef7742b031dfb0976f1ea4ce415f5c495b6efbd31081"
  end

  depends_on "go" => [:build, :test]

  def install
    system "go", "build", "-tags", "noautoupgrade nofirstrun", *std_go_args, "cli/main.go"
  end

  test do
    assert_match "diagnostics", shell_output("#{bin}/akamai install diagnostics")
    system bin/"akamai", "uninstall", "diagnostics"
  end
end
