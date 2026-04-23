class Xplorer < Formula
  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer-community"

  # Binary distribution - platform-specific URLs from xplorer-community releases
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.13/xplorer-1.0.0-alpha.13-darwin-arm64.tar.gz"
      sha256 "c10e449fe14c805128146ae555aa99d4e448bece9831c4adfac9b072fc59e9c1"
    else
      url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.13/xplorer-1.0.0-alpha.13-darwin-x64.tar.gz"
      sha256 "8618f3d4399a558004e2264f32a7d246d5c1ab7667b6a6ea1d8e44722c454459"
    end
  elsif OS.linux?
    # Only x64 supported currently - arm64 can be added when there's demand
    url "https://github.com/XplorerHQ/xplorer-community/releases/download/v1.0.0-alpha.13/xplorer-1.0.0-alpha.13-linux-x64.tar.gz"
    sha256 "593dd1abd633bdc594b29656f7ca22e167db9e78dac7d26f0f21e67bc9d292ff"
  end

  version "1.0.0-alpha.13"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"xplorer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xplorer --version")
  end
end
