class Kestrel < Formula
  desc "Distributed message queue"
  homepage "https://twitter-archive.github.io/kestrel/"
  url "https://twitter-archive.github.io/kestrel/download/kestrel-2.4.1.zip"
  sha256 "5d72a301737cc6cc3908483ce73d4bdb6e96521f3f8c96f93b732d740aaea80c"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/kestrel"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "102f138c80ae525a4087650b554064fb06db3e8d8a507d43e009770fae9975fc"
  end

  # See: https://github.com/twitter-archive/kestrel#status
  deprecate! date: "2016-01-22", because: :deprecated_upstream

  def install
    inreplace "scripts/kestrel.sh" do |s|
      s.change_make_var! "APP_HOME", libexec
      # Fix var paths.
      s.gsub! "/var", var
      # Fix path to script in help message.
      s.gsub! "Usage: /etc/init.d/${APP_NAME}.sh", "Usage: kestrel"
      # Don't call ulimit as not root.
      s.gsub! "ulimit -", "# ulimit -"
    end

    inreplace "config/production.scala", "/var", var

    libexec.install Dir["*"]
    (libexec/"scripts/kestrel.sh").chmod 0755
    (libexec/"scripts/devel.sh").chmod 0755

    (bin/"kestrel").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/scripts/kestrel.sh" "$@"
    EOS
  end

  def post_install
    (var/"log/kestrel").mkpath
    (var/"run/kestrel").mkpath
    (var/"spool/kestrel").mkpath
  end

  test do
    system bin/"kestrel", "status"
  end
end
