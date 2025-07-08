# Release Process

This document outlines the release process for the Modular Flutter project.

## Overview

The project uses automated GitHub workflows to handle testing, building, and releasing packages. The release process supports both automatic releases (triggered by tags) and manual releases (using GitHub's workflow dispatch).

## Release Workflows

### 1. CI Workflow (`.github/workflows/ci.yml`)

**Triggers:**

- Pull requests to `main` branch
- Pushes to `main` branch

**Purpose:**

- Validates all packages
- Runs tests, analysis, and formatting checks
- Performs dry-run publish checks for publishable packages

### 2. Release Workflow (`.github/workflows/release.yml`)

**Triggers:**

- Git tags matching `v*` pattern (e.g., `v1.0.0`)
- Manual workflow dispatch

**Jobs:**

1. **Validate & Test** - Runs comprehensive testing and validation
2. **Build** - Builds all publishable packages
3. **Release** - Creates GitHub release with changelog
4. **Publish** - Optionally publishes packages to pub.dev (manual only)
5. **Update Docs** - Updates CHANGELOG.md

## Package Structure

The monorepo contains the following packages:

- **`packages/modular_core`** - Core functionality (publishable)
- **`packages/modular_flutter`** - Flutter-specific code (not published - marked with `publish_to: none`)
- **`packages/viewmodel`** - ViewModel implementation (publishable)

## Release Methods

### Method 1: Automatic Release (Recommended)

1. **Bump versions** using the provided script:

   ```bash
   ./scripts/bump_version.sh 1.1.0
   ```

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
4. **Fill in the parameters**:
   - Version: `v1.1.0`
   - Create GitHub release: `true`
   - Publish packages: `false` (or `true` if you want to publish)

## Version Bump Script

The `scripts/bump_version.sh` script automates version management across all packages:

### Usage

```bash
./scripts/bump_version.sh <new_version>
```

### Examples

```bash
# Release version
./scripts/bump_version.sh 1.1.0

# Pre-release version
./scripts/bump_version.sh 1.1.0-beta.1

# Patch version
./scripts/bump_version.sh 1.0.1
```

### What it does

- Updates `version` field in all package `pubspec.yaml` files
- Skips packages marked with `publish_to: none`
- Updates or creates `CHANGELOG.md` with new version section
- Provides next steps for committing and tagging

## Publishing to pub.dev

### Prerequisites

To publish packages to pub.dev, you need to set up the following repository secrets:

1. **`PUB_ACCESS_TOKEN`** - OAuth access token from pub.dev
2. **`PUB_REFRESH_TOKEN`** - OAuth refresh token from pub.dev

### Getting pub.dev credentials

1. Run `dart pub token add https://pub.dev` locally
2. Follow the OAuth flow to authenticate
3. Extract tokens from `~/.pub-cache/credentials.json`
4. Add them as repository secrets in GitHub

### Publishing process

Publishing is **only available through manual workflow dispatch** for safety:

1. Navigate to GitHub Actions
2. Run the "Release" workflow
3. Set `publish_packages` to `true`
4. Monitor the workflow for any publishing errors

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

2. **Publishing fails**

   - Verify pub.dev credentials are set correctly
   - Check that package names are available on pub.dev
   - Ensure package documentation and metadata are complete

3. **Tests fail during release**

   - Run `melos run test` locally first
   - Fix any failing tests before creating the release tag

4. **Changelog generation issues**
   - Ensure commit messages follow conventional commit format
   - Check that there are commits since the last tag

### Getting Help

- Check the [GitHub Actions logs](../../actions) for detailed error messages
- Review the workflow files for configuration details
- Ensure all prerequisites are met before starting a release

## Best Practices

1. **Always test locally** before releasing
2. **Use descriptive commit messages** for better changelog generation
3. **Review generated changelogs** before final release
4. **Test published packages** in a separate project
5. **Keep releases small and frequent** rather than large infrequent releases
6. **Document breaking changes** clearly in commit messages and changelogs
