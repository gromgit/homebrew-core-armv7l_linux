class Pilosa < Formula
  desc "Distributed bitmap index that queries across data sets"
  homepage "https://www.pilosa.com"
  url "https://github.com/pilosa/pilosa/archive/v1.4.1.tar.gz"
  sha256 "a250dda8788fefdb0b0b7eeff1bb44375a570cd4c6a0c501bc55612775b1578e"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/pilosa"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a262118a6e0e25c58943015860c7d2017c06b71929dcf8d578a46fae2fda23a6"
  end

  # https://github.com/pilosa/pilosa/issues/2149#issuecomment-993029527
  deprecate! date: "2021-12-14", because: :unmaintained

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    (buildpath/"src/github.com/pilosa/pilosa").install buildpath.children
    cd "src/github.com/pilosa/pilosa" do
      system "make", "build", "FLAGS=-o #{bin}/pilosa", "VERSION=v#{version}"
      prefix.install_metafiles
    end
  end

  service do
    run [opt_bin/"pilosa", "server"]
    keep_alive true
    working_dir var
  end

  test do
    server = fork do
      exec "#{bin}/pilosa", "server"
    end
    sleep 0.5
    assert_match("Welcome. Pilosa is running.", shell_output("curl localhost:10101"))
  ensure
    Process.kill "TERM", server
    Process.wait server
  end
end
