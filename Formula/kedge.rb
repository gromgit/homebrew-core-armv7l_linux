class Kedge < Formula
  desc "Deployment tool for Kubernetes artifacts"
  homepage "https://github.com/kedgeproject/kedge"
  url "https://github.com/kedgeproject/kedge/archive/v0.12.0.tar.gz"
  sha256 "3c01880ba9233fe5b0715527ba32f0c59b25b73284de8cfb49914666a158487b"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/kedge"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "6d94fb719151d230716f00c90e532b63faa126f94d6deb6a24b109427d660113"
  end

  # https://github.com/kedgeproject/kedge/issues/619
  deprecate! date: "2021-02-21", because: :unsupported

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    (buildpath/"src/github.com/kedgeproject").mkpath
    ln_s buildpath, buildpath/"src/github.com/kedgeproject/kedge"
    system "make", "bin"
    bin.install "kedge"
  end

  test do
    (testpath/"kedgefile.yml").write <<~EOS
      name: test
      deployments:
      - containers:
        - image: test
    EOS
    output = shell_output("#{bin}/kedge generate -f kedgefile.yml")
    assert_match "name: test", output
  end
end
