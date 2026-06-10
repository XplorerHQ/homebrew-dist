class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.15/xplorer-1.0.0-alpha.15-darwin-arm64.tar.gz"
      sha256 "fd90b9eacc9213ba65dd95566ce53f75329a60c38d8236d60104fdc9fa335af0"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.15/xplorer-1.0.0-alpha.15-darwin-x64.tar.gz"
      sha256 "0eea150bcb76b613f3cc9e742a80a05010126bc27d0dbdfcdc1c11343565d476"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.15/xplorer-1.0.0-alpha.15-linux-x64.tar.gz"
    sha256 "c816726c3b317cd591dd6e5d93f71bb9183d58b3cf1b264d0fbc166b73c2f68f"
  end

  version "1.0.0-alpha.15"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
