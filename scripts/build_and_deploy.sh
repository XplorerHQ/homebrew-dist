#!/bin/bash

# Build and Deploy Script for XplorerHQ Homebrew Tap
# This script builds wheels/source distributions and updates formulas

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
XPLORER_SOURCE="../xplorer"
XPLORER_CACHE_SOURCE="../xplorer-cache"
HEAVENLY_SOURCE="~/Projects/intus-infrastructure/azure/crossplane-manifests/scripts/heavenly"
BOTTLE_DIR="./bottle"
FORMULA_DIR="./Formula"

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if directory exists
check_directory() {
    if [ ! -d "$1" ]; then
        print_error "Directory $1 not found!"
        print_error "Please ensure you're running this from the homebrew-xplorer repository root"
        print_error "and that $1 exists as a sibling directory."
        exit 1
    fi
}

# Function to get version from pyproject.toml
get_version_from_pyproject() {
    local project_dir="$1"
    if [ -f "$project_dir/pyproject.toml" ]; then
        grep '^version = ' "$project_dir/pyproject.toml" | sed 's/version = "\(.*\)"/\1/'
    else
        print_error "pyproject.toml not found in $project_dir"
        return 1
    fi
}

# Function to get version from setup.py
get_version_from_setup() {
    local project_dir="$1"
    if [ -f "$project_dir/setup.py" ]; then
        python3 -c "import sys; sys.path.insert(0, '$project_dir'); import setup; print(setup.setup_kwargs.get('version', 'unknown'))" 2>/dev/null || \
        grep -E "version\s*=\s*['\"]" "$project_dir/setup.py" | sed -E "s/.*version\s*=\s*['\"]([^'\"]*)['\"].*/\1/" | head -1
    else
        print_error "setup.py not found in $project_dir"
        return 1
    fi
}

# Function to update formula version
update_formula_version() {
    local formula_file="$1"
    local new_version="$2"
    
    if [ -f "$formula_file" ]; then
        # Update version line if it exists, otherwise add it
        if grep -q "version " "$formula_file"; then
            sed -i.bak "s/version \".*\"/version \"$new_version\"/" "$formula_file"
        else
            # Add version line after sha256 line
            sed -i.bak "/sha256 /a\\
  version \"$new_version\"" "$formula_file"
        fi
        rm -f "$formula_file.bak"
        print_status "Updated $formula_file version to $new_version"
    else
        print_error "Formula file $formula_file not found"
        return 1
    fi
}

# Function to build xplorer wheel
# Note: xplorer uses wheel + dependencies approach (not source distribution)
build_xplorer() {
    print_status "Building xplorer wheel..."
    
    cd "$XPLORER_SOURCE"
    
    # Get version from source
    XPLORER_VERSION=$(get_version_from_pyproject "." || get_version_from_setup ".")
    if [ -z "$XPLORER_VERSION" ]; then
        print_error "Could not determine xplorer version"
        exit 1
    fi
    print_status "Detected xplorer version: $XPLORER_VERSION"
    
    # Clean previous builds
    rm -rf dist/ build/
    
    # Build wheel
    uv build --wheel
    
    # Get the wheel filename
    WHEEL_FILE=$(ls dist/*.whl | head -1)
    if [ -z "$WHEEL_FILE" ]; then
        print_error "No wheel file found in $XPLORER_SOURCE/dist/"
        exit 1
    fi
    
    WHEEL_BASENAME=$(basename "$WHEEL_FILE")
    print_status "Built wheel: $WHEEL_BASENAME"
    
    # Copy to bottle directory
    cp "$WHEEL_FILE" "../dist/$BOTTLE_DIR/"
    
    # Calculate SHA256
    cd "../dist"
    XPLORER_SHA256=$(shasum -a 256 "$BOTTLE_DIR/$WHEEL_BASENAME" | cut -d' ' -f1)
    print_status "Xplorer SHA256: $XPLORER_SHA256"
    
    # Update formula URL, SHA256, and version
    sed -i.bak "s|url \".*xplorer.*\"|url \"https://github.com/XplorerHQ/dist/raw/main/bottle/$WHEEL_BASENAME\"|" "$FORMULA_DIR/xplorer.rb"
    sed -i.bak "s/sha256 \".*\"/sha256 \"$XPLORER_SHA256\"/" "$FORMULA_DIR/xplorer.rb"
    rm -f "$FORMULA_DIR/xplorer.rb.bak"
    
    # Update version in formula
    update_formula_version "$FORMULA_DIR/xplorer.rb" "$XPLORER_VERSION"
    
    print_status "Updated xplorer formula with new wheel, SHA256, and version $XPLORER_VERSION"
}

# Function to build xplorer-cache source distribution
# Note: xplorer-cache uses source distribution + virtualenv_install_with_resources approach
build_xplorer_cache() {
    print_status "Building xplorer-cache source distribution..."
    
    cd "$XPLORER_CACHE_SOURCE"
    
    # Get version from source
    XPLORER_CACHE_VERSION=$(get_version_from_pyproject "." || get_version_from_setup ".")
    if [ -z "$XPLORER_CACHE_VERSION" ]; then
        print_error "Could not determine xplorer-cache version"
        exit 1
    fi
    print_status "Detected xplorer-cache version: $XPLORER_CACHE_VERSION"
    
    # Clean previous builds
    rm -rf dist/ build/
    
    # Build both wheel and source distribution
    uv build
    
    # Get the source distribution filename
    SDIST_FILE=$(ls dist/*.tar.gz | head -1)
    if [ -z "$SDIST_FILE" ]; then
        print_error "No source distribution file found in $XPLORER_CACHE_SOURCE/dist/"
        exit 1
    fi
    
    SDIST_BASENAME=$(basename "$SDIST_FILE")
    print_status "Built source distribution: $SDIST_BASENAME"
    
    # Copy to bottle directory
    cp "$SDIST_FILE" "../dist/$BOTTLE_DIR/"
    
    # Calculate SHA256
    cd "../dist"
    XPLORER_CACHE_SHA256=$(shasum -a 256 "$BOTTLE_DIR/$SDIST_BASENAME" | cut -d' ' -f1)
    print_status "Xplorer-cache SHA256: $XPLORER_CACHE_SHA256"
    
    # Update formula URL and SHA256
    sed -i.bak "s|url \".*xplorer_cache.*\"|url \"https://github.com/XplorerHQ/dist/raw/main/bottle/$SDIST_BASENAME\"|" "$FORMULA_DIR/xplorer-cache.rb"
    sed -i.bak "s/sha256 \".*\"/sha256 \"$XPLORER_CACHE_SHA256\"/" "$FORMULA_DIR/xplorer-cache.rb"
    rm -f "$FORMULA_DIR/xplorer-cache.rb.bak"
    
    # Update version in formula
    update_formula_version "$FORMULA_DIR/xplorer-cache.rb" "$XPLORER_CACHE_VERSION"
    
    print_status "Updated xplorer-cache formula with new source distribution, SHA256, and version $XPLORER_CACHE_VERSION"
}

# Function to build heavenly wheel
# Note: heavenly uses wheel + dependencies approach (minimal dependencies)
build_heavenly() {
    print_status "Building heavenly wheel..."
    
    # Expand tilde in path
    HEAVENLY_PATH="${HEAVENLY_SOURCE/#\~/$HOME}"
    
    if [ ! -d "$HEAVENLY_PATH" ]; then
        print_warning "Heavenly source directory not found at $HEAVENLY_PATH"
        print_warning "Skipping heavenly build..."
        return
    fi
    
    cd "$HEAVENLY_PATH"
    
    # Get version from source
    HEAVENLY_VERSION=$(get_version_from_pyproject "." || get_version_from_setup ".")
    if [ -z "$HEAVENLY_VERSION" ]; then
        print_error "Could not determine heavenly version"
        exit 1
    fi
    print_status "Detected heavenly version: $HEAVENLY_VERSION"
    
    # Clean previous builds
    rm -rf dist/ build/
    
    # Build wheel
    uv build --wheel
    
    # Get the wheel filename
    WHEEL_FILE=$(ls dist/*.whl | head -1)
    if [ -z "$WHEEL_FILE" ]; then
        print_error "No wheel file found in $HEAVENLY_PATH/dist/"
        exit 1
    fi
    
    WHEEL_BASENAME=$(basename "$WHEEL_FILE")
    print_status "Built wheel: $WHEEL_BASENAME"
    
    # Copy to bottle directory
    cp "$WHEEL_FILE" "$OLDPWD/$BOTTLE_DIR/"
    
    # Calculate SHA256
    cd "$OLDPWD"
    HEAVENLY_SHA256=$(shasum -a 256 "$BOTTLE_DIR/$WHEEL_BASENAME" | cut -d' ' -f1)
    print_status "Heavenly SHA256: $HEAVENLY_SHA256"
    
    # Update formula URL and SHA256
    sed -i.bak "s|url \".*heavenly.*\"|url \"https://github.com/XplorerHQ/dist/raw/main/bottle/$WHEEL_BASENAME\"|" "$FORMULA_DIR/heavenly.rb"
    sed -i.bak "s/sha256 \".*\"/sha256 \"$HEAVENLY_SHA256\"/" "$FORMULA_DIR/heavenly.rb"
    rm -f "$FORMULA_DIR/heavenly.rb.bak"
    
    # Update version in formula
    update_formula_version "$FORMULA_DIR/heavenly.rb" "$HEAVENLY_VERSION"
    
    print_status "Updated heavenly formula with new wheel, SHA256, and version $HEAVENLY_VERSION"
}

# Function to update formula dependencies
update_dependencies() {
    print_status "Updating formula dependencies..."
    
    # Update xplorer dependencies
    print_status "Updating xplorer dependencies..."
    brew update-python-resources "$FORMULA_DIR/xplorer.rb"
    
    # Update xplorer-cache dependencies
    print_status "Updating xplorer-cache dependencies..."
    brew update-python-resources "$FORMULA_DIR/xplorer-cache.rb"
    
    # Note: heavenly dependencies are manually maintained (click, PyYAML only)
    
    print_status "Dependencies updated successfully"
}

# Function to commit and push changes
commit_changes() {
    print_status "Committing changes..."
    
    # Check if there are changes to commit
    if git diff --quiet && git diff --staged --quiet; then
        print_warning "No changes to commit"
        return
    fi
    
    # Add all changes
    git add "$BOTTLE_DIR/" "$FORMULA_DIR/"
    
    # Get current date for commit message
    COMMIT_DATE=$(date '+%Y-%m-%d %H:%M')
    
    # Commit with descriptive message
    git commit -m "Update formulas, versions, and dependencies - $COMMIT_DATE

- Rebuild xplorer wheel, xplorer-cache source distribution, and heavenly wheel
- Auto-detect and update version numbers from source projects
- Update SHA256 hashes for new distributions
- Regenerate Python dependency resources
- Automated deployment via build_and_deploy.sh"
    
    print_status "Changes committed successfully"
    
    # Ask if user wants to push
    read -p "Push changes to remote repository? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push
        print_status "Changes pushed to remote repository"
    else
        print_warning "Changes committed locally but not pushed"
        print_warning "Run 'git push' manually when ready"
    fi
}

# Main execution
main() {
    print_status "Starting XplorerHQ Homebrew Tap deployment..."
    
    # Check we're in the right directory
    if [ ! -f "DEPLOYMENT_GUIDE.md" ] || [ ! -d "$FORMULA_DIR" ]; then
        print_error "Please run this script from the dist repository root"
        exit 1
    fi
    
    # Check if source directories exist
    check_directory "$XPLORER_SOURCE"
    check_directory "$XPLORER_CACHE_SOURCE"
    
    # Create bottle directory if it doesn't exist
    mkdir -p "$BOTTLE_DIR"
    
    # Build distributions
    build_xplorer
    build_xplorer_cache
    build_heavenly
    
    # Update dependencies
    update_dependencies
    
    # Commit changes
    commit_changes
    
    print_status "Deployment completed successfully!"
    print_status "Users can now install with:"
    print_status "  brew tap XplorerHQ/dist"
    print_status "  brew install xplorer"
    print_status "  brew install xplorer-cache"
    print_status "  brew install heavenly"
}

# Run main function
main "$@"