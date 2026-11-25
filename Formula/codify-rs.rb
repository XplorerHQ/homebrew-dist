class CodifyRs < Formula
  desc "Multi-language L/N/C/P function metrics over tree-sitter"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/codify-rs-v0.1.0/codify-rs-0.1.0-darwin-arm64.tar.gz"
      sha256 "5566f3e14e87be38143c3f85a1fddcd84ba916ab26bc9c3023c0eb7c5d176e9d"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/codify-rs-v0.1.0/codify-rs-0.1.0-darwin-x64.tar.gz"
      sha256 "959f2949c9975b36d47bd03560b34bd7612e5f7a308cd45a73d7d1e292fde0f1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/codify-rs-v0.1.0/codify-rs-0.1.0-linux-arm64.tar.gz"
      sha256 "bf342999330b65c3435590eb3aa234c688b5756f87f778140d5b53f273208bc7"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/codify-rs-v0.1.0/codify-rs-0.1.0-linux-x64.tar.gz"
      sha256 "0a0ec10955643c7eaab536507abce0ef6db9ad2555a47669ea7375d3d9529734"
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
