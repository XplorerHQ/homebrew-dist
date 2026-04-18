class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.11/xplorer-1.0.0-alpha.11-darwin-arm64.tar.gz"
      sha256 "4aa0a7ecc7ce2b90dcd3dc3cd6f16a3e6b746eeb76ea8006b99c3c48ad6c8008"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.11/xplorer-1.0.0-alpha.11-darwin-x64.tar.gz"
      sha256 "1424059291a4d0f486a5743738b830a5e15e05290f34b8c4a34dc4d13ceb235b"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.11/xplorer-1.0.0-alpha.11-linux-x64.tar.gz"
    sha256 "fd4cd25cae80bccb8f3be28f96b7e43f66aacf9f752d36039fa2730c06a327f5"
  end

  version "1.0.0-alpha.11"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
