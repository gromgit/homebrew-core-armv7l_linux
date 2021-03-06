class Logrotate < Formula
  desc "Rotates, compresses, and mails system logs"
  homepage "https://github.com/logrotate/logrotate"
  url "https://github.com/logrotate/logrotate/releases/download/3.20.1/logrotate-3.20.1.tar.xz"
  sha256 "742f6d6e18eceffa49a4bacd933686d3e42931cfccfb694d7f6369b704e5d094"
  license "GPL-2.0"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/logrotate"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "a18d1a516b52cf6b5a26f452aa1589f1fc0fc1ae5efa746728c1b5a3fcac40e5"
  end

  depends_on "popt"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-compress-command=/usr/bin/gzip",
                          "--with-uncompress-command=/usr/bin/gunzip",
                          "--with-state-file-path=#{var}/lib/logrotate.status"
    system "make", "install"

    inreplace "examples/logrotate.conf", "/etc/logrotate.d", "#{etc}/logrotate.d"
    etc.install "examples/logrotate.conf" => "logrotate.conf"
    (etc/"logrotate.d").mkpath
  end

  service do
    run [opt_sbin/"logrotate", etc/"logrotate.conf"]
    run_type :cron
    cron "25 6 * * *"
  end

  test do
    (testpath/"test.log").write("testlograndomstring")
    (testpath/"testlogrotate.conf").write <<~EOS
      #{testpath}/test.log {
        size 1
        copytruncate
      }
    EOS
    system "#{sbin}/logrotate", "-s", "logstatus", "testlogrotate.conf"
    assert(File.size?("test.log").nil?, "File is not zero length!")
  end
end
