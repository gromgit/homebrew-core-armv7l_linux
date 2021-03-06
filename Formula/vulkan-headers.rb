class VulkanHeaders < Formula
  desc "Vulkan Header files and API registry"
  homepage "https://github.com/KhronosGroup/Vulkan-Headers"
  url "https://github.com/KhronosGroup/Vulkan-Headers/archive/v1.3.216.tar.gz"
  sha256 "93f9a70ed9e956f3e0a1b41b71b6d030428cc3509e7e2b38d0ea6ba89b09f71e"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "69181303bac5e05b651f8958990ea0c52c74824048834723466b1b255877b98f"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <vulkan/vulkan_core.h>

      int main() {
        printf("vulkan version %d", VK_VERSION_1_0);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test"
    system "./test"
  end
end
