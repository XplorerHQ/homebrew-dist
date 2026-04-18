class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.12/xplorer-1.0.0-alpha.12-darwin-arm64.tar.gz"
      sha256 "c06020208827c96538bb9e27594f194de179cd04ab936d94e84bc3285d3c8273"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.12/xplorer-1.0.0-alpha.12-darwin-x64.tar.gz"
      sha256 "25b1b78f2133d2b6e092e607afc8a0b0a24df0f0ce514e944cadbf21c140bbcc"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.12/xplorer-1.0.0-alpha.12-linux-x64.tar.gz"
    sha256 "285323d1ccf863e5d6165fad437cb4227f64b5e26458599ccdf3128c087017b4"
  end

  version "1.0.0-alpha.12"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
