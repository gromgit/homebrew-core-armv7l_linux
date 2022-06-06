class Beanstalkd < Formula
  desc "Generic work queue originally designed to reduce web latency"
  homepage "https://beanstalkd.github.io/"
  url "https://github.com/beanstalkd/beanstalkd/archive/v1.12.tar.gz"
  sha256 "f43a7ea7f71db896338224b32f5e534951a976f13b7ef7a4fb5f5aed9f57883f"
  license "MIT"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/beanstalkd"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "70aea515c36f4c29d41122e30237b39776944f831237695abde82052d7c8a8aa"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  service do
    run opt_bin/"beanstalkd"
    keep_alive true
    working_dir var
    log_path var/"log/beanstalkd.log"
    error_log_path var/"log/beanstalkd.log"
  end

  test do
    system "#{bin}/beanstalkd", "-v"
  end
end
