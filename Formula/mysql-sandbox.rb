class MysqlSandbox < Formula
  desc "Install one or more MySQL servers"
  homepage "https://mysqlsandbox.net"
  url "https://github.com/datacharmer/mysql-sandbox/archive/3.2.17.tar.gz"
  sha256 "3af4af111536e4e690042bc80834392f46a7e55c7143332d229ff2eb32321e89"
  license "Apache-2.0"
  revision 1
  head "https://github.com/datacharmer/mysql-sandbox.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/mysql-sandbox"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "5399ccc7dd2cc803410a3fb938a09bb1b7aae7d692f90a3480a8cbd3a68e6b81"
  end

  # Replaced by dbdeployer: https://github.com/datacharmer/dbdeployer
  deprecate! date: "2021-05-24", because: :repo_archived

  uses_from_macos "perl"

  def install
    ENV["PERL_LIBDIR"] = lib/"perl5"
    ENV.prepend_create_path "PERL5LIB", lib/"perl5"

    system "perl", "Makefile.PL", "INSTALL_BASE=#{prefix}", "INSTALLSITEMAN3DIR=#{man3}"
    system "make", "test", "install"

    Pathname.glob("#{bin}/*") do |file|
      next if file.extname == ".sh"

      libexec.install(file)
      file.write_env_script(libexec.join(file.basename), PERL5LIB: ENV["PERL5LIB"])
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/msandbox", 1)
  end
end
