class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.18/xplorer-1.0.0-alpha.18-darwin-arm64.tar.gz"
      sha256 "fbe07a7ff27914ae4040337ff099a08f8b2a81ddcf9d0a84bfe8cf7dae5b12e7"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.18/xplorer-1.0.0-alpha.18-darwin-x64.tar.gz"
      sha256 "00bf5e961fe6faf91fc990ea661b8a84c7a02f72f9c82c1b1085001f6825991e"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.18/xplorer-1.0.0-alpha.18-linux-x64.tar.gz"
    sha256 "630eb1a9cc2c0abbad1a35de9d49a1aaea52ba3bbe6a73151bffa72dfb6df462"
  end

  version "1.0.0-alpha.18"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
