class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer"
  
  # Binary distribution - platform-specific URLs
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/homebrew-dist/releases/download/v1.0.0-alpha.7/xplorer-1.0.0-alpha.7-darwin-arm64.tar.gz"
      sha256 "ce2bca37f651cca07f44121a172e3b8dacd536376caa5e342730b252ad7e7d1b"
    else
      url "https://github.com/XplorerHQ/homebrew-dist/releases/download/v0.5.1/xplorer-0.5.1-darwin-x64.tar.gz"
      sha256 "PLACEHOLDER_X64_SHA256"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/homebrew-dist/releases/download/v0.5.1/xplorer-0.5.1-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_ARM64_SHA256"
    else
      url "https://github.com/XplorerHQ/homebrew-dist/releases/download/v0.5.1/xplorer-0.5.1-linux-x64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_X64_SHA256"
    end
  end

  version "1.0.0-alpha.7"

  # No dependencies - binary is self-contained!

  def install
    # Binary distribution - install entire directory structure
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
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