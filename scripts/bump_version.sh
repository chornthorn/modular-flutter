#!/bin/bash

# Script to bump version across all packages in the monorepo
# Usage: ./scripts/bump_version.sh <new_version>

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to validate version format
validate_version() {
    local version=$1
    if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*)?$ ]]; then
        print_error "Invalid version format: $version"
        print_error "Expected format: x.y.z or x.y.z-alpha.1"
        exit 1
    fi
}

# Function to update version in pubspec.yaml
update_pubspec_version() {
    local package_dir=$1
    local new_version=$2
    local pubspec_file="$package_dir/pubspec.yaml"
    
    if [[ -f "$pubspec_file" ]]; then
        # Check if package should not be published
        if grep -q "publish_to.*none" "$pubspec_file"; then
            print_warning "Skipping $package_dir (marked as publish_to: none)"
            return
        fi
        
        print_info "Updating version in $pubspec_file to $new_version"
        
        # Create backup
        cp "$pubspec_file" "$pubspec_file.backup"
        
        # Update version using sed
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            sed -i '' "s/^version: .*/version: $new_version/" "$pubspec_file"
        else
            # Linux
            sed -i "s/^version: .*/version: $new_version/" "$pubspec_file"
        fi
        
        # Verify the change
        if grep -q "version: $new_version" "$pubspec_file"; then
            print_info "✓ Successfully updated $package_dir"
            rm "$pubspec_file.backup"
        else
            print_error "Failed to update $package_dir"
            mv "$pubspec_file.backup" "$pubspec_file"
            exit 1
        fi
    else
        print_error "pubspec.yaml not found in $package_dir"
        exit 1
    fi
}

# Function to update CHANGELOG.md
update_changelog() {
    local new_version=$1
    local changelog_file="CHANGELOG.md"
    local date=$(date +%Y-%m-%d)
    
    print_info "Updating CHANGELOG.md"
    
    if [[ ! -f "$changelog_file" ]]; then
        # Create new CHANGELOG.md
        cat > "$changelog_file" << EOF
# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

## [$new_version] - $date

### Added
- Initial release

EOF
        print_info "✓ Created new CHANGELOG.md"
    else
        # Add new version section
        # Create temporary file
        temp_file=$(mktemp)
        
        # Read the file and insert new version after "## [Unreleased]"
        awk -v version="$new_version" -v date="$date" '
        /^## \[Unreleased\]/ {
            print $0
            print ""
            print "## [" version "] - " date
            print ""
            print "### Added"
            print "- "
            print ""
            print "### Changed"
            print "- "
            print ""
            print "### Fixed"
            print "- "
            print ""
            next
        }
        { print }
        ' "$changelog_file" > "$temp_file"
        
        mv "$temp_file" "$changelog_file"
        print_info "✓ Updated CHANGELOG.md with version $new_version"
    fi
}

# Main function
main() {
    if [[ $# -ne 1 ]]; then
        print_error "Usage: $0 <new_version>"
        print_error "Example: $0 1.2.0"
        print_error "Example: $0 1.2.0-beta.1"
        exit 1
    fi
    
    local new_version=$1
    
    # Validate version format
    validate_version "$new_version"
    
    # Check if we're in the project root
    if [[ ! -f "pubspec.yaml" ]] || [[ ! -d "packages" ]]; then
        print_error "This script must be run from the project root directory"
        exit 1
    fi
    
    print_info "Bumping version to $new_version across all packages..."
    
    # Find all package directories
    package_dirs=$(find packages -name "pubspec.yaml" -exec dirname {} \;)
    
    if [[ -z "$package_dirs" ]]; then
        print_error "No packages found in the packages directory"
        exit 1
    fi
    
    # Update version in each package
    for package_dir in $package_dirs; do
        update_pubspec_version "$package_dir" "$new_version"
    done
    
    # Update CHANGELOG.md
    update_changelog "$new_version"
    
    print_info "Version bump completed successfully!"
    print_info ""
    print_info "Next steps:"
    print_info "1. Review the changes: git diff"
    print_info "2. Test the packages: melos run test"
    print_info "3. Commit the changes: git add . && git commit -m 'chore: bump version to $new_version'"
    print_info "4. Create a tag: git tag v$new_version"
    print_info "5. Push changes: git push && git push --tags"
}

# Run main function
main "$@" 