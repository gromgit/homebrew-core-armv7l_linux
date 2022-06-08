class Oras < Formula
  desc "OCI Registry As Storage"
  homepage "https://github.com/oras-project/oras"
  url "https://github.com/oras-project/oras/archive/v0.12.0.tar.gz"
  sha256 "5e19d61683a57b414efd75bd1b0290c941b8faace5fcc9d488f5e4aa674bf03e"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/oras"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "00ee3bb58c427f8105447e8a9ee15447fcdf90e63d39edec35ceb6a116842211"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/oras-project/oras/internal/version.Version=#{version}
      -X github.com/oras-project/oras/internal/version.BuildMetadata=Homebrew
    ]
    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/oras"
  end

  test do
    assert_match "#{version}+Homebrew", shell_output("#{bin}/oras version")

    port = free_port
    contents = <<~EOS
      {
        "key": "value",
        "this is": "a test"
      }
    EOS
    (testpath/"test.json").write(contents)
    hash = Digest::SHA256.hexdigest(contents)

    # Although it might not make much sense passing the JSON as both manifest and payload,
    # it helps make the test consistent as the error can randomly switch between either hash
    output = shell_output("oras push localhost:#{port}/test-artifact:v1 " \
                          "--manifest-config test.json:application/vnd.homebrew.test.config.v1+json " \
                          "./test.json 2>&1", 1)
    assert_match %r{
       ^Error:\ failed\ to\ do\ request(.*)
       http://localhost:#{port}/v2/test-artifact/blobs/sha256:#{hash}
    }x, output
  end
end
