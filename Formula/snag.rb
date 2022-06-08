class Snag < Formula
  desc "Automatic build tool for all your needs"
  homepage "https://github.com/Tonkpils/snag"
  url "https://github.com/Tonkpils/snag/archive/v1.2.0.tar.gz"
  sha256 "37bf661436edf4526adf5428ac5ff948871c613ff4f9b61fbbdfe1fb95f58b37"
  license "MIT"
  head "https://github.com/Tonkpils/snag.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/snag"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a701c9515f8efeb9ab53be43cb28bfdefd9fb5ac04cc0932c19e07719949197d"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"

    (buildpath/"src/github.com/Tonkpils/").mkpath
    ln_s buildpath, buildpath/"src/github.com/Tonkpils/snag"

    system "go", "build", "-o", bin/"snag", "./src/github.com/Tonkpils/snag"
  end

  test do
    (testpath/".snag.yml").write <<~EOS
      build:
        - touch #{testpath}/snagged
      verbose: true
    EOS
    begin
      pid = fork do
        exec bin/"snag"
      end
      sleep 0.5
    ensure
      Process.kill "TERM", pid
      Process.wait pid
    end
    assert_predicate testpath/"snagged", :exist?
  end
end
