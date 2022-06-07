class DarkskyWeather < Formula
  desc "Command-line weather from the darksky.net API"
  homepage "https://github.com/genuinetools/weather"
  url "https://github.com/genuinetools/weather/archive/v0.15.7.tar.gz"
  sha256 "e5efd17d40d4246998293de6191e39954aee59c5a0f917f319b493a8dc335edb"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/darksky-weather"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "14925c88e05cc55b30fa6edd0e4e398c8cede33a185391f10e1ebc737894e0d4"
  end

  depends_on "go" => :build

  def install
    project = "github.com/genuinetools/weather"
    ldflags = ["-s -w",
               "-X #{project}/version.GITCOMMIT=#{tap.user.downcase}",
               "-X #{project}/version.VERSION=v#{version}"]
    system "go", "build", *std_go_args(output: bin/"weather", ldflags: ldflags)
  end

  test do
    # A functional test often errors out, so we stick to checking the version.
    assert_match "v#{version}", shell_output("#{bin}/weather version")
  end
end
