class Emp < Formula
  desc "CLI for Empire"
  homepage "https://github.com/remind101/empire"
  url "https://github.com/remind101/empire/archive/v0.13.0.tar.gz"
  sha256 "1294de5b02eaec211549199c5595ab0dbbcfdeb99f670b66e7890c8ba11db22b"
  license "BSD-2-Clause"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/emp"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "44e8825572579d9667cead158b8c3a9e2292485b0781e19549cf73196b0d319d"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"

    (buildpath/"src/github.com/remind101/").mkpath
    ln_s buildpath, buildpath/"src/github.com/remind101/empire"

    system "go", "build", "-o", bin/"emp", "./src/github.com/remind101/empire/cmd/emp"
  end

  test do
    require "webrick"

    server = WEBrick::HTTPServer.new Port: 8035
    server.mount_proc "/apps/foo/releases" do |_req, res|
      resp = {
        "created_at"  => "2015-10-12T0:00:00.00000000-00:00",
        "description" => "my awesome release",
        "id"          => "v1",
        "user"        => {
          "id"    => "zab",
          "email" => "zab@waba.com",
        },
        "version"     => 1,
      }
      res.body = JSON.generate([resp])
    end

    Thread.new { server.start }

    begin
      ENV["EMPIRE_API_URL"] = "http://127.0.0.1:8035"
      assert_match(/v1  zab  Oct 1(1|2|3)  2015  my awesome release/,
        shell_output("#{bin}/emp releases -a foo").strip)
    ensure
      server.shutdown
    end
  end
end
