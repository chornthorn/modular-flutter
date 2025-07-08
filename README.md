# Flutter Starter - Modular Architecture

A comprehensive Flutter starter project implementing clean modular architecture with dependency injection, state management, and multi-platform support.

## Features

### **Modular Architecture**

- Clean separation of concerns with feature modules
- Dependency injection using service locator pattern
- Modular routing with [GoRouter](https://pub.dev/packages/go_router)
- Git-based package management

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
my_modular_app/
├── lib/
│   ├── modules/
│   │   └── post/               # Sample feature module
│   │       ├── models/
│   │       ├── pages/
│   │       ├── repositories/
│   │       ├── services/
│   │       ├── viewmodels/
│   │       ├── post_module.dart
│   │       └── post_router.dart
│   └── main.dart
├── pubspec.yaml
└── ...
```

## Quick Start

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.8.1+)
- [Dart SDK](https://dart.dev/get-dart) (3.8.1+)

### Installation

1. **Create a new Flutter project**

   ```bash
   flutter create my_modular_app
   cd my_modular_app
   ```

2. **Add dependencies to pubspec.yaml**

   ```yaml
   dependencies:
     flutter:
       sdk: flutter

     # Modular Flutter packages
     modular_flutter:
       git:
         url: https://github.com/chornthorn/modular-flutter.git
         path: packages/modular_flutter
         ref: main
     viewmodel:
       git:
         url: https://github.com/chornthorn/modular-flutter.git
         path: packages/viewmodel
         ref: main

     # Additional dependencies
     http: ^1.1.0

   dev_dependencies:
     flutter_test:
       sdk: flutter

     # Code generation
     build_runner: ^2.4.7
     freezed: ^3.1.0
     json_serializable: ^6.7.1
   ```

3. **Install dependencies and run**
   ```bash
   flutter pub get
   flutter run
   ```

## Architecture Overview

### Core Components

#### 1. **Modular Core**

The foundation of the modular architecture providing:

- **Module Base**: Abstract base class for all feature modules
- **App Config**: Environment configuration with type-safe access
- **Result Type**: Rust-inspired error handling
- **Module Router**: Routing abstraction for modules
- **Service Locator**: Dependency injection container

#### 2. **Modular Flutter**

Flutter-specific implementations:

- **ModularApp**: Main app widget with module integration
- **Module Management**: Registration and initialization
- **Flutter Router Integration**: Seamless GoRouter integration

#### 3. **ViewModel**

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
  void registerDependencies(ServiceLocator locator) {
    // Register services
    locator.registerLazySingleton<AuthService>(
      () => AuthService(locator<http.Client>()),
    );

    // Register repositories
    locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator<AuthService>()),
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
    updateState(state.copyWith(status: UiStatus.loading));

    try {
      final user = await _authRepository.login(email, password);
      updateState(state.copyWith(
        status: UiStatus.success,
        user: user,
        errorMessage: null,
      ));
    } catch (e) {
      updateState(state.copyWith(
        status: UiStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
```

### 4. Create State Classes

```dart
@freezed
class LoginState with _$LoginState implements UiState<LoginState> {
  const factory LoginState({
    @Default(UiStatus.initial) UiStatus status,
    User? user,
    String? errorMessage,
  }) = _LoginState;

  const LoginState._();

  @override
  bool get loading => status == UiStatus.loading;

  bool get isInitial => status == UiStatus.initial;
  bool get isLoading => status == UiStatus.loading;
  bool get isSuccess => status == UiStatus.success;
  bool get isError => status == UiStatus.error;
}
```

## Example Implementation

The project includes a complete **Post Module** demonstrating:

- **CRUD Operations**: List, view, create, update, delete posts
- **Repository Pattern**: Clean data layer abstraction
- **State Management**: ViewModel with Riverpod integration
- **Error Handling**: Comprehensive error management
- **Navigation**: Deep linking with GoRouter

### Running the Example

```bash
git clone https://github.com/chornthorn/modular-flutter.git
cd modular-flutter/example
flutter pub get
flutter run
```

Visit the Posts module to see the architecture in action.

## Testing

### Run All Tests

```bash
flutter test
```

### Run Tests for Specific Areas

```bash
# Widget tests
flutter test test/widget_test.dart

# Integration tests
flutter test integration_test/
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

## Module Structure

Each feature module follows a consistent structure:

```
auth_module/
├── models/
│   └── user_model.dart
├── pages/
│   ├── login_screen.dart
│   └── register_screen.dart
├── repositories/
│   ├── auth_repository.dart
│   └── auth_repository_impl.dart
├── services/
│   └── auth_service.dart
├── viewmodels/
│   ├── login/
│   │   ├── login_state.dart
│   │   ├── login_state.freezed.dart
│   │   └── login_viewmodel.dart
│   └── register/
│       ├── register_state.dart
│       ├── register_state.freezed.dart
│       └── register_viewmodel.dart
├── auth_module.dart
└── auth_router.dart
```

## Development Tools

### Useful Commands

```bash
# Install dependencies
flutter pub get

# Run tests
flutter test

# Format code
dart format .

# Analyze code
flutter analyze

# Generate code (freezed, json_serializable)
dart run build_runner build

# Clean build
flutter clean
```

### Code Generation

```bash
# Generate state classes
dart run build_runner build

# Watch for changes
dart run build_runner watch

# Clean generated files
dart run build_runner clean
```

## Multi-Platform Support

This starter supports all Flutter platforms:

- **Android** (API 21+)
- **iOS** (iOS 11+)
- **Web** (Modern browsers)
- **Desktop** (Windows, macOS, Linux)

## Best Practices

### Module Development

1. **Single Responsibility**: Each module handles one feature area
2. **Dependency Injection**: Use service locator for loose coupling
3. **State Management**: Implement ViewModels for business logic
4. **Testing**: Write comprehensive tests for each layer

### Code Organization

1. **Consistent Structure**: Follow the established module structure
2. **Separation of Concerns**: Keep UI, business logic, and data layers separate
3. **Type Safety**: Use Freezed for immutable state classes
4. **Error Handling**: Implement proper error handling at all levels

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Quick Contribution Steps

1. Fork the repository
2. Create a feature branch
3. Make your changes with tests
4. Run `flutter test` to verify
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [Riverpod](https://riverpod.dev) for state management inspiration
- [GoRouter](https://pub.dev/packages/go_router) for navigation
- [Freezed](https://pub.dev/packages/freezed) for immutable classes

## Support

- **Documentation**: Comprehensive guides available
- **Issues**: [GitHub Issues](https://github.com/chornthorn/modular-flutter/issues)
- **Discussions**: [GitHub Discussions](https://github.com/chornthorn/modular-flutter/discussions)

---

**Happy coding!**

_Built with love for the Flutter community_
