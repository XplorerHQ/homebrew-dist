class Heavenly < Formula
  include Language::Python::Virtualenv

  desc "Heavenly Crossplane claim testing and analysis tools"
  homepage "https://github.com/XplorerHQ/heavenly"
  url "https://github.com/XplorerHQ/dist/raw/main/bottle/heavenly-1.0.0-py3-none-any.whl"
  sha256 "8c5e1a8b6b38486bb9190fb49896de7d888b560451795fd852e6f8a01dfd8442"
  version "1.0.0"

  depends_on "python@3.11"

  resource "click" do
    url "https://files.pythonhosted.org/packages/60/6c/8ca2efa64cf75a977a0d7fac081354553ebe483345c734fb6b6515d96bbc/click-8.2.1.tar.gz"
    sha256 "27c491cc05d968d271d5a1db13e3b5a184636d9d930f148c50b038f0d0646202"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/54/ed/79a089b6be93607fa5cdaedf301d7dfb23af5f25c398d5ead2525b063e17/pyyaml-6.0.2.tar.gz"
    sha256 "d584d9ec91ad65861cc08d42e834324ef890a082e591037abe114850ff7bbc3e"
  end

  def install
    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install resources
    # Copy cached download to proper wheel filename for pip
    wheel_file = buildpath/"heavenly-1.0.0-py3-none-any.whl"
    cp cached_download, wheel_file
    venv.pip_install wheel_file
    bin.install_symlink "#{libexec}/bin/test-claim"
    bin.install_symlink "#{libexec}/bin/analyze-render-output"
  end

  def caveats
    <<~EOS
      Heavenly requires the crossplane CLI tool to function properly.
      Install it with: brew install crossplane/tap/crossplane
      
      Commands available:
        test-claim - Test Crossplane claims with auto XR conversion
        analyze-render-output - Analyze existing render output files
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/test-claim --help")
    assert_match "Usage:", shell_output("#{bin}/analyze-render-output --help")
  end
end