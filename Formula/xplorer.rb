class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.17/xplorer-1.0.0-alpha.17-darwin-arm64.tar.gz"
      sha256 "a5b90171847a0598bbde867b1a6f2ed318723b3c8c58aed86110967038340b68"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.17/xplorer-1.0.0-alpha.17-darwin-x64.tar.gz"
      sha256 "5a40eba570c268ff02a097bf0748eb6e3ac51ff9d7a2b81fcaf5d477dcf5f22c"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.17/xplorer-1.0.0-alpha.17-linux-x64.tar.gz"
    sha256 "55d2e3c1f76b7f6c0845c5da5ee2952f6330065b71ca813334c5e930c8c4b334"
  end

  version "1.0.0-alpha.17"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
