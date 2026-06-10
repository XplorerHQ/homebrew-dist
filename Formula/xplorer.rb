class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.15/xplorer-1.0.0-alpha.15-darwin-arm64.tar.gz"
      sha256 "89326961c667d51891e2812c2ba79870bd77c93ee3c740bf76d5370a6dd78019"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.15/xplorer-1.0.0-alpha.15-darwin-x64.tar.gz"
      sha256 "4dd75e5fb500595cbb88e943a05a305a9c315ba23df0411c42a1103b7a416f26"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.15/xplorer-1.0.0-alpha.15-linux-x64.tar.gz"
    sha256 "0060df873196c76b5a000521a559e1c1dfae96e7badb1248bab833f933deab79"
  end

  version "1.0.0-alpha.15"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
