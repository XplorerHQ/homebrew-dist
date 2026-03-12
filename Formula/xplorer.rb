class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.10/xplorer-1.0.0-alpha.10-darwin-arm64.tar.gz"
      sha256 "6acab6b082a4f82c95b56f1c1adfe43456701784fbde5f7581c70d8e49e1ffee"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.10/xplorer-1.0.0-alpha.10-darwin-x64.tar.gz"
      sha256 "08b8e1de0bfc91e4fae81a974c759dfc1dda0df71836eea6044bb2c38f654b0d"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.10/xplorer-1.0.0-alpha.10-linux-x64.tar.gz"
    sha256 "03027b89497a43f1a595498edcd513d2b441a0246684ab010189d5644b2c59df"
  end

  version "1.0.0-alpha.10"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
