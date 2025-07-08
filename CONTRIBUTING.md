# Contributing to Flutter Starter

We love your input! We want to make contributing to this project as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

## Development Process

We use GitHub to host code, track issues and feature requests, as well as accept pull requests.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable version)
- [Dart SDK](https://dart.dev/get-dart) (comes with Flutter)
- [Git](https://git-scm.com/)

### Local Development Setup

1. **Fork the repository** and clone your fork:

   ```bash
   git clone https://github.com/your-username/flutter_starter.git
   cd flutter_starter
   ```

2. **Install dependencies** for all packages:

   ```bash
   # Root project
   flutter pub get

   # Example app
   cd example
   flutter pub get
   cd ..

   # All packages
   cd packages/modular_core
   dart pub get
   cd ../modular_flutter
   flutter pub get
   cd ../viewmodel
   dart pub get
   cd ../..
   ```

3. **Run the example app** to verify setup:
   ```bash
   cd example
   flutter run
   ```

## Project Structure

This project follows a modular architecture with multiple packages:

```
flutter_starter/
├── example/                 # Example Flutter app
├── packages/
│   ├── modular_core/       # Core modular architecture
│   ├── modular_flutter/    # Flutter-specific modular features
│   └── viewmodel/          # ViewModel pattern implementation
└── ...
```

## Code Style Guidelines

### Dart Code Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dart format` to format your code
- Use `dart analyze` to check for issues
- Follow the project's `analysis_options.yaml` rules

### Flutter Specific

- Use `flutter analyze` for Flutter-specific linting
- Follow [Flutter Best Practices](https://flutter.dev/docs/development/best-practices)
- Use meaningful widget names and organize them logically

### Code Formatting

Before submitting, ensure your code is properly formatted:

```bash
# Format all Dart files
dart format .

# Run analysis
dart analyze
flutter analyze  # For Flutter packages
```

## Testing

### Running Tests

```bash
# Run tests for all packages
dart test packages/modular_core/test/
dart test packages/viewmodel/test/
flutter test packages/modular_flutter/test/
flutter test example/test/
```

### Test Guidelines

- Write unit tests for all public APIs
- Include integration tests for complex features
- Aim for >80% code coverage
- Use descriptive test names that explain the behavior being tested

### Test Structure

```dart
void main() {
  group('FeatureName', () {
    late FeatureClass feature;

    setUp(() {
      feature = FeatureClass();
    });

    test('should do something when condition is met', () {
      // Arrange
      // Act
      // Assert
    });
  });
}
```

## Pull Request Process

1. **Create a feature branch** from `main`:

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following the code style guidelines

3. **Add tests** for your changes

4. **Run the full test suite** to ensure nothing is broken

5. **Update documentation** if needed

6. **Commit your changes** with a descriptive message:

   ```bash
   git commit -m "feat: add new feature description"
   ```

7. **Push to your fork** and submit a pull request

### Pull Request Guidelines

- **Title**: Use a clear and descriptive title
- **Description**: Explain what changes you made and why
- **Link issues**: Reference any related issues
- **Screenshots**: Include screenshots for UI changes
- **Tests**: Ensure all tests pass
- **Documentation**: Update relevant documentation

### Commit Message Convention

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat:` A new feature
- `fix:` A bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

## Package-Specific Contributions

### modular_core

- Core functionality that doesn't depend on Flutter
- Focus on clean architecture principles
- Maintain backward compatibility

### modular_flutter

- Flutter-specific implementations
- Widget-based solutions
- Follow Flutter widget conventions

### viewmodel

- State management patterns
- Observable patterns
- Performance optimizations

## Issue Reporting

When reporting issues, please include:

1. **Flutter version**: `flutter --version`
2. **Dart version**: `dart --version`
3. **Operating system**: e.g., macOS 12.0
4. **Device/emulator**: if applicable
5. **Steps to reproduce**
6. **Expected behavior**
7. **Actual behavior**
8. **Error messages/logs**

## Feature Requests

Feature requests are welcome! Please:

1. Check existing issues first
2. Provide a clear use case
3. Explain the expected behavior
4. Consider the impact on existing code
5. Be willing to contribute the implementation

## Code of Conduct

This project follows a Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

## Development Tools

### Recommended IDE Setup

- **VS Code** with Flutter and Dart extensions
- **Android Studio** with Flutter plugin
- **IntelliJ IDEA** with Flutter plugin

### Useful Commands

```bash
# Generate code (for packages using build_runner)
dart run build_runner build

# Clean and get dependencies
flutter clean && flutter pub get

# Run example app
cd example && flutter run

# Generate documentation
dart doc

# Check outdated dependencies
flutter pub outdated
```

## Getting Help

- **Documentation**: Check the README files in each package
- **Discussions**: Use GitHub Discussions for questions
- **Issues**: Report bugs via GitHub Issues
- **Email**: Contact maintainers directly for sensitive issues

## Recognition

Contributors will be recognized in our README and release notes. Thank you for making this project better!

---

**Happy coding!**
