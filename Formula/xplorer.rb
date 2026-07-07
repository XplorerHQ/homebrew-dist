class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.16/xplorer-1.0.0-alpha.16-darwin-arm64.tar.gz"
      sha256 "aaa1b0152b9c6208afe5a3ff2bc4c8bf83346d437e8d63c7c7d7df14fd41b0d8"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.16/xplorer-1.0.0-alpha.16-darwin-x64.tar.gz"
      sha256 "cef70eda8785685f665b527685fad7ca2a32744d786dfad98b43006161690124"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.16/xplorer-1.0.0-alpha.16-linux-x64.tar.gz"
    sha256 "9b7cb1289e482d5dddd58f56cef38a528b5e80608dee0c1b3754942cced32b9a"
  end

  version "1.0.0-alpha.16"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
