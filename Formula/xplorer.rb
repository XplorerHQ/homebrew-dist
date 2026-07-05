class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.16/xplorer-1.0.0-alpha.16-darwin-arm64.tar.gz"
      sha256 "847284ced7c9859b081ef8ebce4776c68ce040fb7c0368f181b4a7de96c90af6"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.16/xplorer-1.0.0-alpha.16-darwin-x64.tar.gz"
      sha256 "955e2106a16907ca6c99cc145ca626e6ca9b8c4844679ab1486b5a2efbde3526"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.16/xplorer-1.0.0-alpha.16-linux-x64.tar.gz"
    sha256 "f0d2c02d98c8a982494b0b687c3f113aac39d97700792932ac0c6666533b97ac"
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
