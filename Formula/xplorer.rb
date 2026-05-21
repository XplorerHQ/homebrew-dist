class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-darwin-arm64.tar.gz"
      sha256 "f8f3489942c518b9c49bfa9572d6b5c52eebcb36cf98cd36d258a900e533835b"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-darwin-x64.tar.gz"
      sha256 "391162702cd369199a02fb7965c386637c7981a8fe6f678792ccb30e726dbd12"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-linux-x64.tar.gz"
    sha256 "2a7d26203bf8f4df6cb24e5211a75e79f16d66b414da8ff34936355f2f26922f"
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
