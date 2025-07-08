# Flutter Starter - Modular Architecture

A comprehensive Flutter starter project implementing clean modular architecture with dependency injection, state management, and multi-platform support.

## Features

### **Modular Architecture**

- Clean separation of concerns with feature modules
- Dependency injection using [GetIt](https://pub.dev/packages/get_it)
- Modular routing with [GoRouter](https://pub.dev/packages/go_router)
- Workspace management with [Melos](https://pub.dev/packages/melos)

### **State Management**

- Custom ViewModel pattern built on [Riverpod](https://pub.dev/packages/flutter_riverpod)
- Type-safe state management with [Freezed](https://pub.dev/packages/freezed)
- Observable state updates with automatic UI refresh

### **Configuration & Environment**

- Environment-based configuration with [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
- Feature flags support
- Type-safe configuration access

### **Developer Experience**

- Comprehensive error handling with Result types
- Code generation for state classes
- Extensive testing setup
- Multi-platform support (Android, iOS, Web, Desktop)

## Project Structure

```
modular_flutter/
├── packages/
│   ├── modular_core/          # Core modular architecture
│   ├── modular_flutter/       # Flutter-specific implementations
│   └── viewmodel/             # State management patterns
├── example/                   # Example Flutter application
│   └── lib/modules/post/      # Sample feature module
└── ...
```

## Quick Start

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.8.1+)
- [Dart SDK](https://dart.dev/get-dart) (3.8.1+)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-username/modular-flutter.git modular_flutter
   cd modular_flutter
   ```

2. **Install dependencies**

   ```bash
   # Install melos globally
   dart pub global activate melos

   # Bootstrap the workspace
   melos bootstrap
   ```

3. **Run the example app**
   ```bash
   cd example
   flutter run
   ```

## Architecture Overview

### Core Components

#### 1. **Modular Core** (`packages/modular_core/`)

The foundation of the modular architecture providing:

- **Module Base**: Abstract base class for all feature modules
- **App Config**: Environment configuration with type-safe access
- **Result Type**: Rust-inspired error handling
- **Module Router**: Routing abstraction for modules
- **Service Locator**: Dependency injection container

#### 2. **Modular Flutter** (`packages/modular_flutter/`)

Flutter-specific implementations:

- **ModularApp**: Main app widget with module integration
- **Module Management**: Registration and initialization
- **Flutter Router Integration**: Seamless GoRouter integration

#### 3. **ViewModel** (`packages/viewmodel/`)

State management solution:

- **ViewModel Base**: Abstract ViewModel with lifecycle management
- **UI State**: Freezed-based state classes
- **Status Management**: Loading, success, error states
- **Riverpod Integration**: Provider-based state management

## Creating a Module

### 1. Define Your Module

```dart
class AuthModule extends Module<AuthRouter> {
  @override
  AuthRouter createRouter() => AuthRouter();

  @override
  String get moduleName => 'auth';

  @override
  void registerDependencies(GetIt locator, AppConfig appConfig) {
    // Register services
    locator.registerLazySingleton<AuthService>(
      () => AuthService(apiBaseUrl: appConfig.apiBaseUrl),
    );

    // Register repositories
    locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator.get<AuthService>()),
    );
  }
}
```

### 2. Create Module Router

```dart
class AuthRouter extends ModuleRouter {
  @override
  String get basePath => '/auth';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '$basePath/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '$basePath/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
  ];
}
```

### 3. Implement ViewModel

```dart
class LoginViewModel extends ViewModel<LoginState> {
  final AuthRepository _authRepository;

  LoginViewModel(this._authRepository) : super(const LoginState());

  Future<void> login(String email, String password) async {
    try {
      state = state.loading;
      final result = await _authRepository.login(email, password);

      result.match(
        onOk: (user) => state = state.success(user),
        onErr: (error) => state = state.error(error.toString()),
      );
    } catch (e) {
      state = state.error(e.toString());
    }
  }
}
```

### 4. Create State Classes

```dart
@freezed
class LoginState with _$LoginState implements UiState {
  const factory LoginState({
    @Default(UiStatus.initial) UiStatus status,
    User? user,
    String? errorMessage,
  }) = _LoginState;

  const LoginState._();

  LoginState get loading => copyWith(status: UiStatus.loading);
  LoginState success(User user) => copyWith(
    status: UiStatus.success,
    user: user,
    errorMessage: null,
  );
  LoginState error(String message) => copyWith(
    status: UiStatus.error,
    errorMessage: message,
  );
}
```

## Example Implementation

The project includes a complete **Post Module** demonstrating:

- **CRUD Operations**: List, view, create, update, delete posts
- **Repository Pattern**: Clean data layer abstraction
- **State Management**: ViewModel with Riverpod integration
- **Error Handling**: Result types for robust error management
- **Navigation**: Deep linking with GoRouter

### Running the Example

```bash
cd example
flutter run
```

Visit the Posts module to see the architecture in action.

## Testing

### Run All Tests

```bash
melos test
```

### Run Tests for Specific Package

```bash
# Core package tests
cd packages/modular_core
dart test

# ViewModel tests
cd packages/viewmodel
dart test

# Example app tests
cd example
flutter test
```

## Configuration

### Environment Variables

Create a `.env` file in your project root:

```env
API_BASE_URL=https://api.example.com
APP_NAME=My Flutter App
DEBUG_MODE=true
FEATURE_NEW_UI=true
```

### App Configuration

```dart
class MyAppConfig extends AppConfig {
  @override
  String get apiBaseUrl => getConfigValue('API_BASE_URL') ?? 'https://api.default.com';

  @override
  String get appName => getConfigValue('APP_NAME') ?? 'Flutter App';

  @override
  bool get isDebugMode => getBoolValue('DEBUG_MODE', fallback: false);
}
```

## Package Documentation

### Modular Core

- [API Documentation](packages/modular_core/README.md)
- Dependency injection patterns
- Module lifecycle management
- Configuration management

### Modular Flutter

- [API Documentation](packages/modular_flutter/README.md)
- Flutter-specific implementations
- Widget integration patterns

### ViewModel

- [API Documentation](packages/viewmodel/README.md)
- State management patterns
- Riverpod integration
- Testing strategies

## Development Tools

### Useful Commands

```bash
# Bootstrap workspace
melos bootstrap

# Run all tests
melos test

# Format code
melos format

# Analyze code
melos analyze

# Generate code (freezed, json_serializable)
melos generate

# Clean all packages
melos clean
```

### Code Generation

```bash
# Generate state classes
dart run build_runner build

# Watch for changes
dart run build_runner watch
```

## Multi-Platform Support

This starter supports all Flutter platforms:

- **Android** (API 21+)
- **iOS** (iOS 11+)
- **Web** (Modern browsers)
- **Desktop** (Windows, macOS, Linux)

## Dependency Management

Dependabot is configured to automatically update dependencies:

- **Weekly updates** for all packages
- **Security updates** prioritized
- **Automated testing** before merging

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Quick Contribution Steps

1. Fork the repository
2. Create a feature branch
3. Make your changes with tests
4. Run `melos test` to verify
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [Riverpod](https://riverpod.dev) for state management inspiration
- [GetIt](https://pub.dev/packages/get_it) for dependency injection
- [GoRouter](https://pub.dev/packages/go_router) for navigation
- [Melos](https://pub.dev/packages/melos) for workspace management

## Support

- **Documentation**: Check package README files
- **Issues**: [GitHub Issues](https://github.com/your-username/flutter_starter/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-username/flutter_starter/discussions)

---

**Happy coding!**

_Built with love for the Flutter community_
