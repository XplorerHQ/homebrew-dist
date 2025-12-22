class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.8/xplorer-1.0.0-alpha.8-darwin-arm64.tar.gz"
      sha256 "d1b17a0418970edb02b6bfd80e0dddb7c0a5e1a24a3d640f83c69b0bd1757878"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.8/xplorer-1.0.0-alpha.8-darwin-x64.tar.gz"
      sha256 "c25012a7ffab39870110c2288e0bb6574b13a92cb4ed6ccc1700688e7131a445"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.8/xplorer-1.0.0-alpha.8-linux-x64.tar.gz"
    sha256 "12fb453d07f7d7c9070d59a07236ed3691f4e409f312771375dbd420d3133bbd"
  end

  version "1.0.0-alpha.8"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
