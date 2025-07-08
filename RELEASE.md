# Release Process

This document outlines the release process for the Modular Flutter project.

## Overview

The project uses automated GitHub workflows to handle testing, building, and creating GitHub releases. The release process supports both automatic releases (triggered by tags) and manual releases (using GitHub's workflow dispatch).

## Release Workflows

### 1. CI Workflow (`.github/workflows/ci.yml`)

**Triggers:**

- Pull requests to `main` branch
- Pushes to `main` branch

**Purpose:**

- Validates all packages
- Runs tests, analysis, and formatting checks
- Generates code using build runners

### 2. Release Workflow (`.github/workflows/release.yml`)

**Triggers:**

- Git tags matching `v*` pattern (e.g., `v1.0.0`)
- Manual workflow dispatch

**Jobs:**

1. **Validate & Test** - Runs comprehensive testing and validation
2. **Release** - Creates GitHub release with changelog
3. **Update Docs** - Updates CHANGELOG.md

## Package Structure

The monorepo contains the following packages:

- **`packages/modular_core`** - Core functionality
- **`packages/modular_flutter`** - Flutter-specific code
- **`packages/viewmodel`** - ViewModel implementation

## Release Methods

### Method 1: Automatic Release (Recommended)

1. **Update package versions** manually in their respective `pubspec.yaml` files:
   - `packages/modular_core/pubspec.yaml`
   - `packages/modular_flutter/pubspec.yaml`
   - `packages/viewmodel/pubspec.yaml`

2. **Review and test** the changes:

   ```bash
   git diff
   melos run test
   ```

3. **Commit the version changes**:

   ```bash
   git add .
   git commit -m "chore: bump version to 1.1.0"
   ```

4. **Create and push the tag**:

   ```bash
   git tag v1.1.0
   git push origin main --tags
   ```

5. **Monitor the workflow** at [GitHub Actions](../../actions)

### Method 2: Manual Release

1. **Navigate to Actions** in your GitHub repository
2. **Select the "Release" workflow**
3. **Click "Run workflow"**
4. **Fill in the version parameter**: `v1.1.0`



## GitHub Release Features

The automated release process creates comprehensive GitHub releases with:

- **Release notes** generated from commit history
- **Package versions** listed in the release description
- **Changelog** automatically generated from git commits
- **Pre-release detection** for versions with suffixes (e.g., `-beta`, `-alpha`)
- **Auto-generated release notes** from GitHub

## Changelog Management

The release process automatically manages `CHANGELOG.md`:

- **Automatic generation** of release notes from git commits
- **Version sections** with date stamps
- **Commit history** included in release notes
- **Package versions** listed in GitHub releases

### Manual changelog editing

You can manually edit `CHANGELOG.md` before releasing:

1. Add detailed descriptions under appropriate sections:

   - `### Added` - New features
   - `### Changed` - Changes in existing functionality
   - `### Fixed` - Bug fixes
   - `### Removed` - Removed features

2. The automated process will preserve your manual entries

## Versioning Strategy

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR** (`1.0.0` → `2.0.0`) - Breaking changes
- **MINOR** (`1.0.0` → `1.1.0`) - New features (backward compatible)
- **PATCH** (`1.0.0` → `1.0.1`) - Bug fixes (backward compatible)

### Pre-release versions

- **Alpha**: `1.1.0-alpha.1` - Early development
- **Beta**: `1.1.0-beta.1` - Feature-complete, testing phase
- **RC**: `1.1.0-rc.1` - Release candidate

## Troubleshooting

### Common Issues

1. **Workflow fails on version validation**

   - Ensure version follows semantic versioning format
   - Check that all package versions are synchronized

2. **Tests fail during release**

   - Run `melos run test` locally first
   - Fix any failing tests before creating the release tag

3. **Changelog generation issues**

   - Ensure commit messages follow conventional commit format
   - Check that there are commits since the last tag

4. **Release creation fails**
   - Verify GitHub token permissions
   - Check that the tag doesn't already exist

### Getting Help

- Check the [GitHub Actions logs](../../actions) for detailed error messages
- Review the workflow files for configuration details
- Ensure all prerequisites are met before starting a release

## Best Practices

1. **Always test locally** before releasing
2. **Use descriptive commit messages** for better changelog generation
3. **Review generated changelogs** before final release
4. **Keep releases small and frequent** rather than large infrequent releases
5. **Document breaking changes** clearly in commit messages and changelogs
6. **Test the release process** on feature branches when making workflow changes
