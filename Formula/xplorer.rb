class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-darwin-arm64.tar.gz"
      sha256 "644be12c4f9a107a4050105baf7e63ccf9b1606edcef4ea0b8c74854a622cb03"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-darwin-x64.tar.gz"
      sha256 "4224da67d1ccc7a43dc9161c912a557c55444121afbf34bed4fdeba55948bb92"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-linux-x64.tar.gz"
    sha256 "015453c0ed872912bd380450f18f6198008daa211a24d3ab762b3573e96fec3e"
  end

  version "1.0.0-alpha.14"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
