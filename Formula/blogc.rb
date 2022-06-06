class Blogc < Formula
  desc "Blog compiler with template engine and markup language"
  homepage "https://blogc.rgm.io/"
  url "https://github.com/blogc/blogc/releases/download/v0.20.1/blogc-0.20.1.tar.xz"
  sha256 "d1289367362b7b11b438670fe703ff2c751e795393c06e1999d6b9a6e438fdd8"
  license "BSD-3-Clause"
  head "https://github.com/blogc/blogc.git", branch: "master"

  bottle do
    root_url "https://github.com/gromgit/homebrew-core-armv7l_linux/releases/download/blogc"
    sha256 cellar: :any_skip_relocation, armv7l_linux: "ed67b41a9de82ad1321a7d05be287249505a6fac000cb3b35b48c2e357a53b43"
  end

  def install
    system "./configure", "--disable-tests",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-git-receiver",
                          "--enable-make",
                          "--enable-runserver",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # Write config file that describes folder structure
    (testpath/"blogcfile").write <<~EOS
      [global]
      AUTHOR_NAME = Homebrew
      AUTHOR_EMAIL = brew@example.org
      SITE_TITLE = Homebrew
      SITE_TAGLINE = The Missing Package Manager for macOS (or Linux)
      BASE_DOMAIN = http://example.org

      [settings]
      locale = en_US.utf8

      [posts]
      post1
      post2
    EOS

    # Set up folder structure for a basic example site
    mkdir_p "content/post"
    mkdir_p "templates"
    (testpath/"content/post/post1.txt").write "----------\nfoo"
    (testpath/"content/post/post2.txt").write "----------\nbar"

    (testpath/"templates/main.tmpl").write <<~EOS
      <html>
      {{ SITE_TITLE }}
      {{ SITE_TAGLINE }}
      {% block listing %}{{ CONTENT }}{% endblock %}
      </html>
    EOS

    # Generate static files
    system bin/"blogc-make"

    # Run basic checks on generated files
    output = (testpath/"_build/index.html").read
    assert_match "Homebrew\nThe Missing Package Manager for macOS (or Linux)", output
    assert_match "<p>bar</p>\n<p>foo</p>", output
  end
end
