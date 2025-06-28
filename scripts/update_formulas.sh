#!/bin/bash

# Update Formulas Script for XplorerHQ Homebrew Tap
# This script only updates formula dependencies without rebuilding distributions

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
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

# Function to update dependencies for a specific formula
update_formula_dependencies() {
    local formula_file="$1"
    local formula_name=$(basename "$formula_file" .rb)
    
    print_status "Updating dependencies for $formula_name..."
    
    if [ ! -f "$formula_file" ]; then
        print_error "Formula file $formula_file not found!"
        exit 1
    fi
    
    # Create backup
    cp "$formula_file" "$formula_file.backup"
    
    # Update dependencies using brew tool
    if brew update-python-resources "$formula_file"; then
        print_status "Successfully updated dependencies for $formula_name"
        rm -f "$formula_file.backup"
    else
        print_error "Failed to update dependencies for $formula_name"
        # Restore backup on failure
        mv "$formula_file.backup" "$formula_file"
        exit 1
    fi
}

# Function to validate formula syntax
validate_formula() {
    local formula_file="$1"
    local formula_name=$(basename "$formula_file" .rb)
    
    print_status "Validating formula syntax for $formula_name..."
    
    # Basic syntax check using Ruby
    if ruby -c "$formula_file" > /dev/null 2>&1; then
        print_status "Formula syntax is valid for $formula_name"
    else
        print_error "Formula syntax is invalid for $formula_name"
        ruby -c "$formula_file"
        exit 1
    fi
}

# Function to show dependency summary
show_dependency_summary() {
    local formula_file="$1"
    local formula_name=$(basename "$formula_file" .rb)
    
    local resource_count=$(grep -c "^  resource " "$formula_file" 2>/dev/null || echo "0")
    print_status "$formula_name has $resource_count dependency resources"
}

# Function to commit changes
commit_changes() {
    print_status "Checking for changes to commit..."
    
    # Check if there are changes to commit
    if git diff --quiet "$FORMULA_DIR/"; then
        print_warning "No formula changes to commit"
        return
    fi
    
    # Show what changed
    print_status "Formula changes detected:"
    git diff --name-only "$FORMULA_DIR/"
    
    # Add formula changes
    git add "$FORMULA_DIR/"
    
    # Get current date for commit message
    COMMIT_DATE=$(date '+%Y-%m-%d %H:%M')
    
    # Commit with descriptive message
    git commit -m "Update formula dependencies - $COMMIT_DATE

- Regenerate Python dependency resources for all formulas
- Ensure all transitive dependencies are properly declared
- Automated update via update_formulas.sh"
    
    print_status "Formula changes committed successfully"
    
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
    print_status "Starting XplorerHQ Homebrew formula dependency update..."
    
    # Check we're in the right directory
    if [ ! -f "DEPLOYMENT_GUIDE.md" ] || [ ! -d "$FORMULA_DIR" ]; then
        print_error "Please run this script from the homebrew-xplorer repository root"
        exit 1
    fi
    
    # Check if brew is available
    if ! command -v brew &> /dev/null; then
        print_error "Homebrew (brew) is not installed or not in PATH"
        print_error "Please install Homebrew first: https://brew.sh"
        exit 1
    fi
    
    # Update dependencies for all formulas
    for formula_file in "$FORMULA_DIR"/*.rb; do
        if [ -f "$formula_file" ]; then
            update_formula_dependencies "$formula_file"
            validate_formula "$formula_file"
            show_dependency_summary "$formula_file"
        fi
    done
    
    # Show summary
    print_status "Dependency update summary:"
    for formula_file in "$FORMULA_DIR"/*.rb; do
        if [ -f "$formula_file" ]; then
            show_dependency_summary "$formula_file"
        fi
    done
    
    # Commit changes
    commit_changes
    
    print_status "Formula dependency update completed successfully!"
}

# Show usage if help requested
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: $0"
    echo ""
    echo "Update Python dependencies for all Homebrew formulas in this tap."
    echo "This script uses 'brew update-python-resources' to regenerate"
    echo "dependency resources for each formula."
    echo ""
    echo "The script will:"
    echo "  1. Update dependencies for all .rb files in Formula/ directory"
    echo "  2. Validate formula syntax"
    echo "  3. Show dependency summary"
    echo "  4. Commit changes (with user confirmation)"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
    exit 0
fi

# Run main function
main "$@"