# ViewModel Package Tests

This directory contains comprehensive unit tests for all components of the viewmodel package.

## Test Files

### 1. `viewmodel_status_test.dart`

Tests the `Status` enum that represents different states:

- **Coverage**: Enum values, string representations, equality, switch statements
- **Tests**: 4 test cases covering all Status enum functionality
- **Key Features Tested**:
  - All enum values exist (initial, loading, success, error)
  - String representations are correct
  - Equality comparison works properly
  - Can be used in switch statements

### 2. `viewmodel_state_test.dart`

Tests the `UiState` abstract base class:

- **Coverage**: State creation, status methods, copyWith, immutability, Freezed integration
- **Tests**: 11 test groups with 17 individual test cases
- **Key Features Tested**:
  - Constructor with default and custom values
  - Status convenience methods (isInitial, isLoading, isSuccess, isError)
  - Loading state creation
  - copyWith functionality
  - Equality and hash code
  - toString representation
  - Immutability guarantees

### 3. `viewmodel_test.dart`

Tests the `ViewModel` abstract base class:

- **Coverage**: Initialization, state management, lifecycle, async operations, error handling
- **Tests**: 8 test groups with 15 individual test cases
- **Key Features Tested**:
  - Initialization with initial state
  - onInit lifecycle method
  - State property access (state and uiState)
  - State updates and immutability
  - Listener notifications
  - Async operation handling
  - Error state management
  - Disposal and cleanup
  - Riverpod integration

### 4. `viewmodel_observer_test.dart`

Tests the `ViewModelObserver` for logging and debugging:

- **Coverage**: Observer configuration, lifecycle logging, state change logging, error logging
- **Tests**: 6 test groups with 11 individual test cases
- **Key Features Tested**:
  - Constructor with default and custom settings
  - Provider lifecycle logging (creation/disposal)
  - State change logging (normal and verbose)
  - Error logging
  - Integration with ViewModels
  - Performance impact when logging disabled

### 5. `all_tests.dart`

Test suite runner that executes all tests in organized groups.

### 6. `simple_status_test.dart`

Simplified test for Status enum without Flutter dependencies (for environments with Flutter SDK issues).

## Running Tests

### Individual Test Files

```bash
# Run specific test file
dart test test/viewmodel_status_test.dart --reporter=expanded

# Run with simple test (no Flutter dependencies)
dart test test/simple_status_test.dart --reporter=expanded
```

### All Tests

```bash
# Run all tests
dart test

# Run with specific reporter
dart test --reporter=expanded

# Run test suite
dart test test/all_tests.dart
```

## Test Structure

Each test file follows a consistent structure:

```dart
void main() {
  group('ComponentName', () {
    group('feature group', () {
      test('specific behavior', () {
        // Arrange
        // Act
        // Assert
      });
    });
  });
}
```

## Test Coverage

The test suite provides comprehensive coverage for:

✅ **Status Enum**: All values, operations, and usage patterns  
✅ **UiState Base Class**: Construction, state management, immutability  
✅ **ViewModel Base Class**: Lifecycle, state changes, async operations  
✅ **ViewModelObserver**: Logging, debugging, performance monitoring  
✅ **Integration**: Riverpod provider integration  
✅ **Error Handling**: Error states, disposal, edge cases

## Test Utilities

The tests include several utility classes:

- `TestUiState`: Manual implementation of UiState for testing
- `TestViewModel`: Test implementation with controllable behavior
- `MockLogger`: Mock logger for testing observer functionality
- `TestNotifier`: Simple StateNotifier for provider testing

## Troubleshooting

### Flutter SDK Issues

If you encounter Flutter SDK compilation errors, use the simple test:

```bash
dart test test/simple_status_test.dart
```

### Freezed Code Generation

Make sure to generate Freezed code before running tests:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Dependencies

Ensure all dev dependencies are installed:

```bash
dart pub get
```

## Test Quality

The test suite follows best practices:

- **Isolation**: Each test is independent
- **Descriptive Names**: Clear test and group names
- **Comprehensive**: Tests cover happy path, edge cases, and error conditions
- **Fast Execution**: Tests run quickly without external dependencies
- **Maintainable**: Well-organized with helper utilities
- **Documentation**: Clear comments explaining complex test scenarios

## Adding New Tests

When adding new functionality to the viewmodel package:

1. Create or extend appropriate test file
2. Follow the existing naming conventions
3. Add tests to the `all_tests.dart` suite
4. Ensure comprehensive coverage of new features
5. Update this README if adding new test files
