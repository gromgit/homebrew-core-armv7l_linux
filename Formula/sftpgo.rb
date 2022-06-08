class Sftpgo < Formula
  desc "Fully featured SFTP server with optional HTTP/S, FTP/S and WebDAV support"
  homepage "https://github.com/drakkan/sftpgo"
  url "https://github.com/drakkan/sftpgo/releases/download/v2.3.0/sftpgo_v2.3.0_src_with_deps.tar.xz"
  sha256 "2a1c6dc2c540404e7a19e9ba3b43224cb040fb6c05b3f4ad24cc20da0c34b93f"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/sftpgo"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "4bbe0fe401264fb714012f99407f20295e31f04150ff26c4276843f96a261e59"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
    system bin/"sftpgo", "gen", "man", "-d", man1

    (zsh_completion/"_sftpgo").write Utils.safe_popen_read(bin/"sftpgo", "gen", "completion", "zsh")
    (bash_completion/"sftpgo").write Utils.safe_popen_read(bin/"sftpgo", "gen", "completion", "bash")
    (fish_completion/"sftpgo.fish").write Utils.safe_popen_read(bin/"sftpgo", "gen", "completion", "fish")

    inreplace "sftpgo.json" do |s|
      s.gsub! "\"users_base_dir\": \"\"", "\"users_base_dir\": \"#{var}/sftpgo/data\""
      s.gsub! "\"templates_path\": \"templates\"", "\"templates_path\": \"#{opt_pkgshare}/templates\""
      s.gsub! "\"static_files_path\": \"static\"", "\"static_files_path\": \"#{opt_pkgshare}/static\""
      s.gsub! "\"openapi_path\": \"openapi\"", "\"openapi_path\": \"#{opt_pkgshare}/openapi\""
    end

    pkgetc.install "sftpgo.json"
    pkgshare.install "static", "templates", "openapi"
    (var/"sftpgo").mkpath
  end

  def caveats
    <<~EOS
      Default data location:

      #{var}/sftpgo

      Configuration file location:

      #{pkgetc}/sftpgo.json
    EOS
  end

  plist_options startup: true
  service do
    run [bin/"sftpgo", "serve", "--config-file", etc/"sftpgo/sftpgo.json", "--log-file-path",
         var/"sftpgo/log/sftpgo.log"]
    keep_alive true
    working_dir var/"sftpgo"
  end

  test do
    expected_output = "ok"
    http_port = free_port
    sftp_port = free_port
    ENV["SFTPGO_HTTPD__BINDINGS__0__PORT"] = http_port.to_s
    ENV["SFTPGO_HTTPD__BINDINGS__0__ADDRESS"] = "127.0.0.1"
    ENV["SFTPGO_SFTPD__BINDINGS__0__PORT"] = sftp_port.to_s
    ENV["SFTPGO_SFTPD__BINDINGS__0__ADDRESS"] = "127.0.0.1"
    ENV["SFTPGO_SFTPD__HOST_KEYS"] = "#{testpath}/id_ecdsa,#{testpath}/id_ed25519"
    ENV["SFTPGO_LOG_FILE_PATH"] = ""
    pid = fork do
      exec bin/"sftpgo", "serve", "--config-file", "#{pkgetc}/sftpgo.json"
    end

    sleep 5
    assert_match expected_output, shell_output("curl -s 127.0.0.1:#{http_port}/healthz")
    system "ssh-keyscan", "-p", sftp_port.to_s, "127.0.0.1"
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
  end
end
