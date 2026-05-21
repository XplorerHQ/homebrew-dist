class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-darwin-arm64.tar.gz"
      sha256 "b596081ce8f0a8d7fbda135e79fad1739a6c671aa5a5419945ac1f0b0c22f4b3"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-darwin-x64.tar.gz"
      sha256 "b0fc6dfc129cd5c44dd8ffd5b388dc26ca7a847717d4338d63834ec401028b2d"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-linux-x64.tar.gz"
    sha256 "d8bd1895dbb4c2c96484b1da172061d222ecf41ce8e0a22b17b7f71205b878d4"
  end

  version "1.0.0-alpha.14"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
