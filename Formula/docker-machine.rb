class DockerMachine < Formula
  desc "Create Docker hosts locally and on cloud providers"
  homepage "https://docs.docker.com/machine"
  url "https://github.com/docker/machine.git",
      tag:      "v0.16.2",
      revision: "bd45ab13d88c32a3dd701485983354514abc41fa"
  license "Apache-2.0"
  head "https://github.com/docker/machine.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/docker-machine"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "01ab0404af2508df95f69063c754ac5d79e3f7afd2c08ae4ace6f02827e08b13"
  end

  deprecate! date: "2021-09-30", because: :repo_archived

  depends_on "automake" => :build
  depends_on "go" => :build

  conflicts_with "docker-machine-completion", because: "docker-machine already includes completion scripts"

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    (buildpath/"src/github.com/docker/machine").install buildpath.children
    cd "src/github.com/docker/machine" do
      system "make", "build"
      bin.install Dir["bin/*"]
      bash_completion.install Dir["contrib/completion/bash/*.bash"]
      zsh_completion.install "contrib/completion/zsh/_docker-machine"
      prefix.install_metafiles
    end
  end

  plist_options manual: "docker-machine start"
  service do
    run [opt_bin/"docker-machine", "start", "default"]
    environment_variables PATH: std_service_path_env
    run_type :immediate
    working_dir HOMEBREW_PREFIX
  end

  test do
    assert_match version.to_s, shell_output(bin/"docker-machine --version")
  end
end
