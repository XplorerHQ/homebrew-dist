class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-darwin-arm64.tar.gz"
      sha256 "b173bc289d57a1302352eef1df804c9d24e940266cfbd9fc8e9e9153611590cf"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-darwin-x64.tar.gz"
      sha256 "cd12c9666864001ac5e68257087608a01111315c3cf2da94a3cfa5916d391f3e"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-linux-x64.tar.gz"
    sha256 "a8c3ebbc5b4642b1988f49f050fe2da690ecc612ba5caf3f7ec5486e3d3ee3c4"
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
