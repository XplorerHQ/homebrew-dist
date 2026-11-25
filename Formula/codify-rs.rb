class CodifyRs < Formula
  desc "Multi-language L/N/C/P function metrics over tree-sitter"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/codify-rs-v0.1.0/codify-rs-0.1.0-darwin-arm64.tar.gz"
      sha256 "745b6e2ba8e5d53aea8e922bcc0caeb391f4d3c582e769dab6384ac273d0bcfa"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/codify-rs-v0.1.0/codify-rs-0.1.0-darwin-x64.tar.gz"
      sha256 "6101b4e24eab29aa6be25c8f8c7bd22b4274356b1e7caf8467b8dfe1b8104f25"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/codify-rs-v0.1.0/codify-rs-0.1.0-linux-arm64.tar.gz"
      sha256 "e70cf73ef2d997770339bf6969fdd11f3dc90c9217e7da64af536c4f6cb1a46c"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/codify-rs-v0.1.0/codify-rs-0.1.0-linux-x64.tar.gz"
      sha256 "b152d3e8c51f2923d3c1586c63b49e74fd83c1a9eebcbd2bfac402fa9c67060d"
    end
  end

  version "0.1.0"
  license "MIT"

  def install
    bin.install "codify-rs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codify-rs --version")
  end
end
