class Subfinder < Formula
  desc "Subdomain discovery tool"
  homepage "https://github.com/projectdiscovery/subfinder"
  url "https://github.com/projectdiscovery/subfinder/archive/v2.5.1.tar.gz"
  sha256 "c93daf616ad3c0f60e91a2626a97c7cfcc3662735db5e6e0b1e2bd0706638fb2"
  license "MIT"
  head "https://github.com/projectdiscovery/subfinder.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/subfinder"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "8f236d5bbfe588e9a7e5457a47681237452e8de90e53df879300c14c76e361a6"
  end

  depends_on "go" => :build

  def install
    cd "v2" do
      system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/subfinder"
    end
  end

  test do
    assert_match "docs.brew.sh", shell_output("#{bin}/subfinder -d brew.sh")
    assert_predicate testpath/".config/subfinder/config.yaml", :exist?
  end
end
