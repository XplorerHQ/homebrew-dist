class Xplorer < Formula
  include Language::Python::Virtualenv

  desc "Crossplane resource explorer with claim-based discovery"
  homepage "https://github.com/XplorerHQ/xplorer"
  url "https://github.com/XplorerHQ/homebrew-dist/raw/main/bottle/xplorer-0.3.0-py3-none-any.whl"
  sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  version "0.3.0"

  depends_on "python@3.11"

  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/6c/81/3747dad6b14fa2cf53fcf10548cf5aea6913e96fab41a3c198676f8948a5/cachetools-5.5.2.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/73/f7/f14b46d4bcd21092d7d3ccef689615220d8a08fb25e564b65d20738e672e/certifi-2025.6.15.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/e4/33/89c2ced2b67d1c2a61c19c6751aa8902d46ce3dacb23600a283619f5a12d/charset_normalizer-3.4.2.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "durationpy" do
    url "https://files.pythonhosted.org/packages/9d/a4/e44218c2b394e31a6dd0d6b095c4e1f32d0be54c2a4b250032d717647bab/durationpy-0.10.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "google-auth" do
    url "https://files.pythonhosted.org/packages/9e/9b/e92ef23b84fa10a64ce4831390b7a4c2e53c0132568d99d4ae61d04c8855/google_auth-2.40.3.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f1/70/7703c29685631f5a7590aa73f1f1d3fa9a380e654b86af429e0934a32f7d/idna-3.10.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "kubernetes" do
    url "https://files.pythonhosted.org/packages/ae/52/19ebe8004c243fdfa78268a96727c71e08f00ff6fe69a301d0b7fcbce3c2/kubernetes-33.1.0.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/38/71/3b932df36c1a044d397a1f92d1cf91ee0a503d91e470cbd670aa66b07ed0/markdown-it-py-3.0.0.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "oauthlib" do
    url "https://files.pythonhosted.org/packages/0b/5f/19930f824ffeb0ad4372da4812c50edbd1434f678c90c2733e1188edfc63/oauthlib-3.3.1.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/ba/e9/01f1a64245b89f039897cb0130016d79f77d52669aae6ee7b159a6c4c018/pyasn1-0.6.1.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "pyasn1-modules" do
    url "https://files.pythonhosted.org/packages/e9/e6/78ebbb10a8c8e4b61a59249394a4a594c1a7af95593dc933a349c8d00964/pyasn1_modules-0.4.2.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/b0/77/a5b8c569bf593b0140bde72ea885a803b82086995367bf2037de0159d924/pygments-2.19.2.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/54/ed/79a089b6be93607fa5cdaedf301d7dfb23af5f25c398d5ead2525b063e17/pyyaml-6.0.2.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/e1/0a/929373653770d8a0d7ea76c37de6e41f11eb07559b103b1c02cafb3f7cf8/requests-2.32.4.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "requests-oauthlib" do
    url "https://files.pythonhosted.org/packages/42/f2/05f29bc3913aea15eb670be136045bf5c5bbf4b99ecb839da9b422bb2c85/requests-oauthlib-2.0.0.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/a1/53/830aa4c3066a8ab0ae9a9955976fb770fe9c6102117c8ec4ab3ea62d89e8/rich-14.0.0.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "rsa" do
    url "https://files.pythonhosted.org/packages/da/8a/22b7beea3ee0d44b1916c0c1cb0ee3af23b700b6da9f04991899d0c555d4/rsa-4.9.1.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/94/e7/b2c673351809dca68a0e064b6af791aa332cf192da575fd474ed7d6f16a2/six-1.17.0.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "types-urllib3" do
    url "https://files.pythonhosted.org/packages/73/de/b9d7a68ad39092368fb21dd6194b362b98a1daeea5dcfef5e1adb5031c7e/types-urllib3-1.26.25.14.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/15/22/9ee70a2574a4f4599c47dd506532914ce044817c7752a79b6a51286319bc/urllib3-2.5.0.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  resource "websocket-client" do
    url "https://files.pythonhosted.org/packages/e6/30/fba0d96b4b5fbf5948ed3f4681f7da2f9f64512e1d303f94b4cc174c24a5/websocket_client-1.8.0.tar.gz"
    sha256 "273f145fa98289ab8d4e36097d2abbfc5978f2e8637a8df066ddd018cb400ad0"
  end

  def install
    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install resources
    # Copy cached download to proper wheel filename for pip
    wheel_file = buildpath/"xplorer-0.3.0-py3-none-any.whl"
    cp cached_download, wheel_file
    venv.pip_install wheel_file
    bin.install_symlink "#{libexec}/bin/xplorer"
  end

  def caveats
    <<~EOS
      To use xplorer with your Crossplane cluster, ensure you have kubectl configured
      and your kubeconfig properly set up.
    EOS
  end

  test do
    assert_match "usage: xplorer", shell_output("#{bin}/xplorer --help")
  end
end