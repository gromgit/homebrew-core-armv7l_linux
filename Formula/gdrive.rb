class Gdrive < Formula
  desc "Google Drive CLI Client"
  homepage "https://github.com/prasmussen/gdrive"
  url "https://github.com/prasmussen/gdrive/archive/2.1.1.tar.gz"
  sha256 "9092cb356acf58f2938954784605911e146497a18681199d0c0edc65b833a672"
  license "MIT"
  head "https://github.com/prasmussen/gdrive.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/gdrive"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a4736ecbcb58b84ac0959912b66128fd5cba076ee9338f58614f9ba2f140e717"
  end

  depends_on "go" => :build

  patch do
    url "https://github.com/prasmussen/gdrive/commit/faa6fc3dc104236900caa75eb22e9ed2e5ecad42.patch?full_index=1"
    sha256 "ee7ebe604698aaeeb677c60d973d5bd6c3aca0a5fb86f6f925c375a90fea6b95"
  end

  def install
    system "go", "build", *std_go_args, "-mod=readonly"
    doc.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gdrive version")
  end
end
