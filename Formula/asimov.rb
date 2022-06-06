class Asimov < Formula
  desc "Automatically exclude development dependencies from Time Machine backups"
  homepage "https://github.com/stevegrunwell/asimov"
  url "https://github.com/stevegrunwell/asimov/archive/v0.3.0.tar.gz"
  sha256 "77a0ef09c86d9d6ff146547902c749c43bc054f331a12ecb9992db9673469fab"
  license "MIT"
  head "https://github.com/stevegrunwell/asimov.git", branch: "develop"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/asimov"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "cc5b798ca071f989f7a5f32945eb50524c515038bfc38c0d8322c04c7da7e33c"
  end

  def install
    bin.install buildpath/"asimov"
  end

  plist_options startup: true

  # Asimov will run in the background on a daily basis
  service do
    run opt_bin/"asimov"
    run_type :interval
    interval 86400 # 24 hours = 60 * 60 * 24
  end

  test do
    assert_match "Finding dependency directories with corresponding definition files…",
                 shell_output("#{bin}/asimov")
  end
end
