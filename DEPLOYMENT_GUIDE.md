# Homebrew Tap Deployment Guide

This guide covers the complete deployment process for the XplorerHQ Homebrew tap with `xplorer`, `xplorer-cache`, and `heavenly` formulas.

## Repository Structure

```
dist/                               # This repository (XplorerHQ/dist)
├── Formula/
│   ├── xplorer.rb                  # Main Crossplane explorer formula
│   ├── xplorer-cache.rb            # Cache server formula
│   └── heavenly.rb                 # Crossplane testing tools formula
├── bottle/                         # Pre-built distributions
│   ├── xplorer-0.1.0-py3-none-any.whl
│   ├── xplorer_cache-0.1.0.tar.gz
│   └── [60+ dependency wheels]    # All Python dependencies
├── scripts/                        # Deployment automation scripts
│   ├── update_formulas.sh         # Update all formulas with new versions
│   ├── build_and_deploy.sh        # Build wheels and deploy to tap
│   └── test_installation.sh       # Test formula installations
└── DEPLOYMENT_GUIDE.md            # This guide
```

## Prerequisites

1. **Access to repositories:**
   - `XplorerHQ/xplorer` - Source code for xplorer app
   - `XplorerHQ/xplorer-cache` - Source code for xplorer-cache app  
   - `XplorerHQ/dist` - This homebrew tap repository
   - `~/Projects/intus-infrastructure/azure/crossplane-manifests/scripts/heavenly` - Heavenly tools

2. **Required tools:**
   - `brew` (Homebrew)
   - `uv` (Python package manager)
   - `git`
   - Python 3.11+

3. **Repository setup:**
   ```bash
   # Clone repositories in parent directory
   cd /path/to/development
   git clone https://github.com/XplorerHQ/xplorer.git
   git clone https://github.com/XplorerHQ/xplorer-cache.git
   git clone https://github.com/XplorerHQ/dist.git
   ```

## Deployment Process

### 1. Manual Deployment Steps

#### For xplorer (main application):

1. **Build new wheel:**
   ```bash
   cd xplorer/
   uv build --wheel
   ```

2. **Copy wheel to tap repository:**
   ```bash
   cp dist/xplorer-*.whl ../dist/bottle/
   ```

3. **Update formula dependencies:**
   ```bash
   cd ../dist/
   brew update-python-resources Formula/xplorer.rb
   ```

4. **Update version and SHA256:**
   ```bash
   # Calculate new SHA256
   shasum -a 256 bottle/xplorer-*.whl
   
   # Edit Formula/xplorer.rb to update:
   # - url with new filename
   # - sha256 with calculated hash
   # - version if changed
   ```

#### For xplorer-cache:

1. **Build source distribution and wheel:**
   ```bash
   cd xplorer-cache/  # Assuming separate repo
   uv build  # Builds both .tar.gz and .whl
   ```

2. **Copy source distribution to tap repository:**
   ```bash
   cp dist/xplorer_cache-*.tar.gz ../dist/bottle/
   ```

3. **Update formula dependencies:**
   ```bash
   cd ../dist/
   brew update-python-resources Formula/xplorer-cache.rb
   ```

4. **Update version and SHA256:**
   ```bash
   # Calculate new SHA256
   shasum -a 256 bottle/xplorer_cache-*.tar.gz
   
   # Edit Formula/xplorer-cache.rb to update:
   # - url with new filename
   # - sha256 with calculated hash
   # - version if changed
   ```

#### For heavenly:

1. **Build wheel:**
   ```bash
   cd ~/Projects/intus-infrastructure/azure/crossplane-manifests/scripts/heavenly
   uv build --wheel
   ```

2. **Copy wheel to tap repository:**
   ```bash
   cp dist/heavenly-*.whl /path/to/dist/bottle/
   ```

3. **Update formula dependencies (minimal - only click and PyYAML):**
   ```bash
   cd /path/to/dist/
   # Dependencies are manually maintained due to simple requirements
   ```

4. **Update version and SHA256:**
   ```bash
   # Calculate new SHA256
   shasum -a 256 bottle/heavenly-*.whl
   
   # Edit Formula/heavenly.rb to update:
   # - url with new filename
   # - sha256 with calculated hash
   # - version if changed
   ```

### 2. Automated Deployment (Using Scripts)

#### Build and Deploy Script:
```bash
# From dist directory
./scripts/build_and_deploy.sh
```

#### Update Formulas Only:
```bash
# Update just the dependency resources
./scripts/update_formulas.sh
```

#### Test Installation:
```bash
# Test both formulas work correctly
./scripts/test_installation.sh
```

## Formula Best Practices

### 1. Dependencies Management
- **Two approaches available:**
  - **Source distributions** (.tar.gz): Use with `virtualenv_install_with_resources` - simpler, no wheel filename issues
  - **Wheel files** (.whl): Requires declaring ALL dependencies as resources and custom install method
- **Declare ALL dependencies** as resources using `brew update-python-resources`
- **Use virtual environment** for proper isolation

### 2. Version Updates
- Update version in source project's `pyproject.toml`
- Rebuild distributions with `uv build`
- Update formula URL and SHA256
- Regenerate dependency resources

### 3. Testing
- Always test locally before pushing: `brew install --force formula-name`
- Test both clean installs and upgrades
- Verify command line tools work: `xplorer --help`, `xplorer-cache --help`

## Common Issues and Solutions

### 1. Installation Fails with "Directory not installable"
**Problem:** Using wheel with `virtualenv_install_with_resources` or wheel filename issues

**Solution Options:**
**Option A (Source Distribution):**
- Build source distribution: `uv build` (creates both .tar.gz and .whl)
- Copy .tar.gz to bottle/ directory
- Update formula URL to point to .tar.gz file
- Use `virtualenv_install_with_resources`

**Option B (Wheel + Dependencies):**
- Declare ALL dependencies as resources using `brew update-python-resources`
- Use custom install method:
  ```ruby
  def install
    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install resources
    # Copy cached download to proper wheel filename for pip
    wheel_file = buildpath/"app-version-py3-none-any.whl"
    cp cached_download, wheel_file
    venv.pip_install wheel_file
    bin.install_symlink "#{libexec}/bin/app-name"
  end
  ```

### 2. Missing Dependencies Error
**Problem:** Not all dependencies declared as resources (especially when using wheel files)

**Solution:**
```bash
brew update-python-resources Formula/your-formula.rb
```

### 3. "Invalid wheel filename" Error
**Problem:** Homebrew's cached download has hash prefix that pip doesn't recognize

**Solution:** Copy cached download to proper filename before installation:
```ruby
wheel_file = buildpath/"app-version-py3-none-any.whl"
cp cached_download, wheel_file
venv.pip_install wheel_file
```

### 4. Wrong Python Version
**Problem:** Formula specifies wrong Python version

**Solution:**
- Ensure `depends_on "python@3.11"` matches your project requirements
- Use consistent Python version in virtualenv creation

### 5. Binary Linking Conflicts
**Problem:** `brew link` fails due to python3 binary conflicts

**Solution:** Only symlink application binaries, not python binaries:
```ruby
bin.install_symlink "#{libexec}/bin/app-name"  # Instead of Dir["#{libexec}/bin/*"]
```

## Testing Checklist

Before releasing new version:

- [ ] Both wheels/source distributions build successfully
- [ ] All dependency resources updated with `brew update-python-resources`
- [ ] SHA256 hashes updated in formulas
- [ ] Local installation test passes: `brew install --force xplorer`
- [ ] Local installation test passes: `brew install --force xplorer-cache`
- [ ] Local installation test passes: `brew install --force heavenly`
- [ ] Command line tools work: `xplorer --help` and `xplorer-cache --help`
- [ ] Heavenly commands work: `test-claim --help` and `analyze-render-output --help`
- [ ] Clean uninstall/reinstall works
- [ ] Formulas pass basic audit: `brew audit --formula Formula/*.rb`

## Version Release Workflow

1. **Update source projects** with new version in `pyproject.toml`
2. **Build new distributions** using provided scripts
3. **Update formulas** with new versions and dependencies
4. **Test locally** using test script
5. **Commit and push** to homebrew-xplorer repository
6. **Tag release** (optional) for version tracking

## User Installation

Once deployed, users can install via:

```bash
# Add the tap
brew tap XplorerHQ/dist

# Install applications
brew install xplorer          # Crossplane resource explorer
brew install xplorer-cache    # Cache server (optional)
brew install heavenly         # Crossplane testing tools

# Usage
xplorer --help
xplorer-cache --help
test-claim --help
analyze-render-output --help
```

## Troubleshooting

### For Developers
- Check logs: `/Users/$(whoami)/Library/Logs/Homebrew/formula-name/`
- Test formula syntax: `brew audit --formula Formula/name.rb`
- Debug installation: `brew install --verbose --debug formula-name`

### For Users
- Update Homebrew: `brew update`
- Reinstall if broken: `brew uninstall formula-name && brew install formula-name`
- Report issues: https://github.com/XplorerHQ/dist/issues

---

*This deployment guide ensures consistent, reliable releases of the XplorerHQ Homebrew tap.*