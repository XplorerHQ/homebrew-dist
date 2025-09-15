class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer"
  
  # Binary distribution - platform-specific URLs
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer/releases/download/v0.5.0/xplorer-0.5.0-darwin-arm64.tar.gz"
      sha256 "ccd69a74df95c779b86346ae4468066ba376ce8375541cd67d5c8bda1c2bc5ad"
    else
      url "https://github.com/XplorerHQ/xplorer/releases/download/v0.5.0/xplorer-0.5.0-darwin-x64.tar.gz"
      sha256 "PLACEHOLDER_X64_SHA256"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer/releases/download/v0.5.0/xplorer-0.5.0-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_ARM64_SHA256"
    else
      url "https://github.com/XplorerHQ/xplorer/releases/download/v0.5.0/xplorer-0.5.0-linux-x64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_X64_SHA256"
    end
  end
  
  version "0.5.0"

  # No dependencies - binary is self-contained!

  def install
    # Binary distribution - simply copy the binary to bin/
    bin.install "xplorer"
  end

  def caveats
    <<~EOS
      To use xplorer with your Crossplane cluster, ensure you have kubectl configured
      and your kubeconfig properly set up.
      
      This binary distribution provides significantly faster startup (0.4s)
      compared to the previous Python-based installation.
    EOS
  end

  test do
    assert_match "usage: xplorer", shell_output("#{bin}/xplorer --help")
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end