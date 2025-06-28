#!/bin/bash

# Test Installation Script for XplorerHQ Homebrew Tap
# This script tests that both formulas install and work correctly

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
TAP_NAME="XplorerHQ/xplorer"
FORMULAS=("xplorer" "xplorer-cache" "heavenly")

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

print_test() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

# Function to check if formula is installed
is_formula_installed() {
    local formula="$1"
    brew list --formula | grep -q "^$formula$"
}

# Function to uninstall formula if installed
uninstall_formula() {
    local formula="$1"
    if is_formula_installed "$formula"; then
        print_status "Uninstalling existing $formula..."
        brew uninstall "$formula"
    fi
}

# Function to test formula installation
test_formula_installation() {
    local formula="$1"
    
    print_test "Testing installation of $formula..."
    
    # Uninstall if already installed
    uninstall_formula "$formula"
    
    # Install formula
    print_status "Installing $formula..."
    if brew install "$formula"; then
        print_status "✓ $formula installed successfully"
    else
        print_error "✗ Failed to install $formula"
        return 1
    fi
    
    # Verify installation
    if is_formula_installed "$formula"; then
        print_status "✓ $formula is properly installed"
    else
        print_error "✗ $formula not found in installed formulas"
        return 1
    fi
    
    return 0
}

# Function to test command availability
test_command_availability() {
    local command="$1"
    
    print_test "Testing command availability: $command"
    
    # Check if command is available
    if command -v "$command" &> /dev/null; then
        local command_path=$(which "$command")
        print_status "✓ Command '$command' is available at: $command_path"
        
        # Verify it's the Homebrew version (should be in /opt/homebrew/bin)
        if [[ "$command_path" == /opt/homebrew/bin/* ]]; then
            print_status "✓ Using Homebrew-installed version"
        else
            print_warning "⚠ Command found but not from Homebrew path: $command_path"
        fi
        
        # Test help command
        print_test "Testing help output for $command..."
        if "$command" --help &> /dev/null; then
            print_status "✓ '$command --help' works correctly"
        else
            print_warning "⚠ '$command --help' failed (may be expected for some commands)"
        fi
    else
        print_error "✗ Command '$command' is not available in PATH"
        return 1
    fi
    
    return 0
}

# Function to test formula functionality
test_formula_functionality() {
    local formula="$1"
    
    print_test "Testing functionality of $formula..."
    
    case "$formula" in
        "xplorer")
            test_command_availability "xplorer"
            ;;
        "xplorer-cache")
            test_command_availability "xplorer-cache"
            ;;
        "heavenly")
            test_command_availability "test-claim"
            test_command_availability "analyze-render-output"
            ;;
        *)
            print_warning "No specific functionality test for $formula"
            ;;
    esac
}

# Function to test formula audit
test_formula_audit() {
    local formula="$1"
    
    print_test "Running brew audit for $formula..."
    
    if brew audit --formula "$formula" 2>/dev/null; then
        print_status "✓ $formula passes brew audit"
    else
        print_warning "⚠ $formula has audit warnings (may be acceptable)"
        # Show the audit output for debugging
        brew audit --formula "$formula" || true
    fi
}

# Function to cleanup after tests
cleanup_test_installations() {
    print_status "Cleaning up test installations..."
    
    for formula in "${FORMULAS[@]}"; do
        if is_formula_installed "$formula"; then
            print_status "Uninstalling $formula..."
            brew uninstall "$formula" || true
        fi
    done
}

# Function to run comprehensive test for a formula
run_formula_tests() {
    local formula="$1"
    local test_passed=true
    
    print_status "========================================"
    print_status "Testing formula: $formula"
    print_status "========================================"
    
    # Test installation
    if ! test_formula_installation "$formula"; then
        test_passed=false
    fi
    
    # Test functionality (only if installation succeeded)
    if [ "$test_passed" = true ]; then
        if ! test_formula_functionality "$formula"; then
            test_passed=false
        fi
    fi
    
    # Test audit
    test_formula_audit "$formula"
    
    if [ "$test_passed" = true ]; then
        print_status "✓ All tests passed for $formula"
    else
        print_error "✗ Some tests failed for $formula"
    fi
    
    return $([ "$test_passed" = true ] && echo 0 || echo 1)
}

# Function to check tap status
check_tap_status() {
    print_test "Checking tap status..."
    
    if brew tap | grep -q "$TAP_NAME"; then
        print_status "✓ Tap $TAP_NAME is installed"
        
        # Show available formulas
        print_status "Available formulas in tap:"
        brew search "$TAP_NAME/" | sed 's/^/  - /'
    else
        print_error "✗ Tap $TAP_NAME is not installed"
        print_status "Installing tap..."
        brew tap "$TAP_NAME"
    fi
}

# Main execution
main() {
    print_status "Starting XplorerHQ Homebrew Tap installation tests..."
    
    # Check if brew is available
    if ! command -v brew &> /dev/null; then
        print_error "Homebrew (brew) is not installed or not in PATH"
        print_error "Please install Homebrew first: https://brew.sh"
        exit 1
    fi
    
    # Check tap status
    check_tap_status
    
    # Track overall test results
    local overall_success=true
    
    # Test each formula
    for formula in "${FORMULAS[@]}"; do
        if ! run_formula_tests "$formula"; then
            overall_success=false
        fi
        echo  # Empty line for readability
    done
    
    # Summary
    print_status "========================================"
    print_status "Test Summary"
    print_status "========================================"
    
    if [ "$overall_success" = true ]; then
        print_status "🎉 All formula tests passed!"
        print_status ""
        print_status "Users can now install with:"
        print_status "  brew tap $TAP_NAME"
        for formula in "${FORMULAS[@]}"; do
            print_status "  brew install $formula"
        done
    else
        print_error "❌ Some formula tests failed!"
        print_error "Please check the errors above and fix before deploying."
    fi
    
    # Ask about cleanup
    read -p "Remove test installations? (Y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        cleanup_test_installations
        print_status "Test installations cleaned up"
    fi
    
    # Exit with appropriate code
    exit $([ "$overall_success" = true ] && echo 0 || echo 1)
}

# Show usage if help requested
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: $0 [--no-cleanup]"
    echo ""
    echo "Test installation and functionality of all formulas in the XplorerHQ tap."
    echo ""
    echo "The script will:"
    echo "  1. Check that the tap is properly installed"
    echo "  2. Test installation of each formula"
    echo "  3. Test that command-line tools work"
    echo "  4. Run brew audit on each formula"
    echo "  5. Clean up test installations (optional)"
    echo ""
    echo "Options:"
    echo "  -h, --help       Show this help message"
    echo "  --no-cleanup     Don't ask about cleaning up test installations"
    exit 0
fi

# Handle --no-cleanup option
if [[ "$1" == "--no-cleanup" ]]; then
    # Override cleanup function to do nothing
    cleanup_test_installations() {
        print_status "Skipping cleanup due to --no-cleanup flag"
    }
fi

# Run main function
main "$@"