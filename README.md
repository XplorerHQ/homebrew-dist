# XplorerHQ Homebrew Tap

A Homebrew tap for XplorerHQ applications and tools.

## Installation

### Install the tap

```bash
brew tap XplorerHQ/dist
```

### Install applications

#### xplorer

Crossplane resource explorer with claim-based discovery.

```bash
brew install XplorerHQ/dist/xplorer
```

#### xplorer-cache

CLI for xplorer cache server.

```bash
brew install XplorerHQ/dist/xplorer-cache
```

#### heavenly

Heavenly Crossplane claim testing and analysis tools.

```bash
brew install XplorerHQ/dist/heavenly
```

Or after tapping:

```bash
brew install xplorer
brew install xplorer-cache
brew install heavenly
```

## Available Formulas

| Formula | Description | Version |
|---------|-------------|---------|
| `xplorer` | Crossplane resource explorer with claim-based discovery | 0.1.0 |
| `xplorer-cache` | CLI for xplorer cache server | 0.1.0 |
| `heavenly` | Heavenly Crossplane claim testing and analysis tools | 1.0.0 |

## Usage

After installation, you can use the applications directly from your terminal:

```bash
# Example usage for xplorer - Crossplane resource explorer
xplorer --help                    # Show help
xplorer --all                     # List all claims in the cluster
xplorer my-claim                  # Explore a specific claim
xplorer --unhealthy --all         # Show only unhealthy claims
xplorer --kind CompositeDatabase  # Show all claims for specific kind

# Example usage for xplorer-cache
xplorer-cache --help

# Example usage for heavenly - Crossplane testing tools
test-claim --help                                  # Show available subcommands
test-claim render /path/to/claim.yaml              # Render a claim to XR
test-claim apply /path/to/claim.yaml               # Apply a claim
test-claim fetch-observed                          # Fetch observed state
analyze-render-output /path/to/render-output.yaml  # Analyze existing output
```

## Development

This tap includes automated deployment scripts and comprehensive documentation:

- **Deployment Guide**: See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) for complete deployment process
- **Build Scripts**: Located in `scripts/` directory for automated builds
- **Testing**: Use `scripts/test_installation.sh` to test formulas

### Quick Development Workflow

1. Update source applications and version numbers
2. Run automated deployment:
   ```bash
   ./scripts/build_and_deploy.sh
   ```
3. Test the formulas:
   ```bash
   ./scripts/test_installation.sh
   ```

### Manual Testing

Test individual formulas locally:

```bash
# Test after tapping locally
brew install --force xplorer
brew install --force xplorer-cache
```

## Support

For issues with:
- **Formulas**: Open an issue in this repository
- **Applications**: Open an issue in the respective application repository

## License

This tap is maintained by XplorerHQ. Individual applications may have their own licenses.
