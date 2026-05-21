class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-darwin-arm64.tar.gz"
      sha256 "11d2797ed02a3c15ecdd4118b47dd677b6559155d7e831db3d56e70d52932833"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-darwin-x64.tar.gz"
      sha256 "fd1e88e289128828c8466b291231456d8c832fd3fb9e0079f1938fceaded1f81"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.14/xplorer-1.0.0-alpha.14-linux-x64.tar.gz"
    sha256 "56d3650312cc7000524cf313aae9fcc3745036552e1f0e0a4924896134ae6da7"
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
