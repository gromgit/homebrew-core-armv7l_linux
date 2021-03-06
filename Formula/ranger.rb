class Ranger < Formula
  include Language::Python::Shebang

  desc "File browser"
  homepage "https://ranger.github.io"
  url "https://ranger.github.io/ranger-1.9.3.tar.gz"
  sha256 "ce088a04c91c25263a9675dc5c43514b7ec1b38c8ea43d9a9d00923ff6cdd251"
  license "GPL-3.0-or-later"
  revision 2
  head "https://github.com/ranger/ranger.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/ranger"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "2972a3ffed7cb61dcd1abe64cb6d24b902ffc50ef78e10fc279ebda56175a1d8"
  end

  depends_on "python@3.10"

  def install
    man1.install "doc/ranger.1"
    libexec.install "ranger.py", "ranger"
    rewrite_shebang detected_python_shebang, libexec/"ranger.py"
    bin.install_symlink libexec/"ranger.py" => "ranger"

    (buildpath/"rifle.py").write <<~EOS
      #!/usr/bin/python -O
      import sys
      from ranger.ext import rifle
      sys.exit(rifle.main())
    EOS
    chmod 0700, buildpath/"rifle.py"
    libexec.install "rifle.py"
    rewrite_shebang detected_python_shebang, libexec/"rifle.py"
    bin.install_symlink libexec/"rifle.py" => "rifle"

    doc.install "examples"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ranger --version")
  end
end
