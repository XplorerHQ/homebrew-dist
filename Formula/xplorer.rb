class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.10/xplorer-1.0.0-alpha.10-darwin-arm64.tar.gz"
      sha256 "1836de43321660aa015f361b1b84a9914e4ac1aa9170104fe6c12781a0a140c1"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.10/xplorer-1.0.0-alpha.10-darwin-x64.tar.gz"
      sha256 "399cbdb38111cc2e447dc71e0ad495beb86be93106ab74e22be928f7d14c6287"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.10/xplorer-1.0.0-alpha.10-linux-x64.tar.gz"
    sha256 "afc07eedd3ee4095efe2d15ec63b96c39d2e07be9dfc41b17d769485a0101bde"
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
