require "language/node"

class Cdk8s < Formula
  desc "Define k8s native apps and abstractions using object-oriented programming"
  homepage "https://cdk8s.io/"
  url "https://registry.npmjs.org/cdk8s-cli/-/cdk8s-cli-2.0.11.tgz"
  sha256 "2c7b44aea50a6a636848783ae2da127139c530f779e53179946527ea7c3dce3c"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "6af24cc5a221c97ef4927c817a35173a1f5f31549f542c8e5db1ee005441e11a"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "Cannot initialize a project in a non-empty directory",
      shell_output("#{bin}/cdk8s init python-app 2>&1", 1)
  end
end
