class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.9/xplorer-1.0.0-alpha.9-darwin-arm64.tar.gz"
      sha256 "5cd6fbdaaf7f28f945fdd11d30513e54e3ed347d05dfd263e9a03dc747177f45"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.9/xplorer-1.0.0-alpha.9-darwin-x64.tar.gz"
      sha256 "0cf0fae024d6795d382a07f107e90987d5f130f92558b5f7e57f5ce295bd6417"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.9/xplorer-1.0.0-alpha.9-linux-x64.tar.gz"
    sha256 "3c7b1ad6136f799669fc858d7cdca942f271337f35eef9781e0da929d90b1217"
  end

  version "1.0.0-alpha.9"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
