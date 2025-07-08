# ViewModel Package

A Flutter package that provides a structured ViewModel pattern built on top of Riverpod for state management. This package simplifies the creation of ViewModels with consistent state handling, status management, and debugging capabilities.

## Features

- 🏗️ **Structured ViewModel Pattern**: Clean separation between UI and business logic
- 🔄 **Status Management**: Built-in loading, success, error, and initial states
- 🐛 **Debug Logging**: Comprehensive logging of state changes and errors
- ⚡ **Riverpod Integration**: Built on top of Flutter Riverpod for reactive state management
- 🧪 **Testable**: Easy to unit test with clear state management
- 📦 **Type Safe**: Full type safety with generic ViewModel and UiState classes
- ❄️ **Freezed Integration**: Uses Freezed for immutable state classes with automatic code generation

## Core Concepts

### ViewModel

The abstract `ViewModel<State>` class extends Riverpod's `StateNotifier` and provides:

- Automatic initialization with `onInit()` lifecycle method
- Type-safe state management
- Consistent API for all ViewModels

### UiState

The abstract `UiState<T>` class provides:

- Built-in status tracking (initial, loading, success, error)
- Message and error message handling
- Base class for Freezed-generated immutable state classes
- Convenient status checking methods (`isLoading`, `isSuccess`, etc.)

### Status

An enum defining the four core states:

- `Status.initial` - ViewModel created but no operations started
- `Status.loading` - Operation in progress
- `Status.success` - Operation completed successfully
- `Status.error` - Operation failed

## Getting Started

### 1. Define Your State with Freezed

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:viewmodel/viewmodel.dart';

part 'counter_ui_state.freezed.dart';

@freezed
class CounterUiState extends UiState<CounterUiState> with _$CounterUiState {
  const CounterUiState._();

  const factory CounterUiState({
    required int value,
    @Default(Status.initial) Status status,
    String? message,
    String? errorMessage,
  }) = _CounterUiState;

  @override
  CounterUiState get loading => copyWith(status: Status.loading);
}
```

### 2. Generate the Freezed Code

Run the build runner to generate the Freezed code:

```bash
dart pub get
dart pub run build_runner build
```

### 3. Create Your ViewModel

```dart
import 'package:viewmodel/viewmodel.dart';

class CounterViewModel extends ViewModel<CounterUiState> {
  CounterViewModel() : super(const CounterUiState(value: 0));

  @override
  Future<void> onInit() async {
    // Initialize your ViewModel here
    // Load initial data, set up listeners, etc.
  }

  void increment() {
    state = state.copyWith(
      value: state.value + 1,
      status: Status.success,
    );
  }

  void decrement() {
    state = state.copyWith(
      value: state.value - 1,
      status: Status.success,
    );
  }

  Future<void> reset() async {
    state = state.loading;

    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 500));

    state = state.copyWith(
      value: 0,
      status: Status.success,
      message: 'Counter reset successfully',
    );
  }
}
```

### 4. Create a Provider

```dart
import 'package:viewmodel/viewmodel.dart';

final counterViewModelProvider = StateNotifierProvider<CounterViewModel, CounterUiState>(
  (ref) => CounterViewModel(),
);
```

### 5. Use in Your UI

```dart
import 'package:flutter/material.dart';
import 'package:viewmodel/viewmodel.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(counterViewModelProvider);
    final viewModel = ref.read(counterViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.isLoading)
              const CircularProgressIndicator()
            else
              Text(
                '${state.value}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

            if (state.message != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  state.message!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

            if (state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  state.errorMessage!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: viewModel.decrement,
                  child: const Text('-'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: viewModel.increment,
                  child: const Text('+'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: viewModel.reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 6. Setup ProviderScope with Observers (Optional)

Add the `ProviderScope` at the root of your app for debugging and provider configuration:

```dart
import 'package:flutter/material.dart';
import 'package:viewmodel/viewmodel.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        ViewModelObserver(
          logStateChanges: true,
          logErrors: true,
          logProviderLifecycle: false,
        ),
      ],
      child: const MyApp(),
    ),
  );
}
```

## Advanced Usage

### Error Handling

```dart
import 'package:viewmodel/viewmodel.dart';

Future<void> loadData() async {
  state = state.loading;

  try {
    final result = await repository.fetchData();
    state = state.copyWith(
      data: result,
      status: Status.success,
      message: 'Data loaded successfully',
    );
  } catch (error) {
    state = state.copyWith(
      status: Status.error,
      errorMessage: 'Failed to load data: $error',
    );
  }
}
```

### Complex State with Multiple Properties

```dart
@freezed
class UserProfileUiState extends UiState<UserProfileUiState> with _$UserProfileUiState {
  const UserProfileUiState._();

  const factory UserProfileUiState({
    User? user,
    @Default([]) List<Post> posts,
    @Default(false) bool isRefreshing,
    @Default(Status.initial) Status status,
    String? message,
    String? errorMessage,
  }) = _UserProfileUiState;

  @override
  UserProfileUiState get loading => copyWith(status: Status.loading);
}
```

### Custom Observer Configuration

```dart
import 'package:flutter/foundation.dart';
import 'package:viewmodel/viewmodel.dart';

ViewModelObserver(
  logStateChanges: kDebugMode,      // Log state changes in debug mode
  logErrors: true,                  // Always log errors
  logProviderLifecycle: false,      // Don't log provider lifecycle
  verbose: false,                   // Concise logging
)
```

## Testing

ViewModels are easy to test since they extend `StateNotifier`:

```dart
import 'package:test/test.dart';
import 'package:viewmodel/viewmodel.dart';

void main() {
  group('CounterViewModel', () {
    late CounterViewModel viewModel;

    setUp(() {
      viewModel = CounterViewModel();
    });

    test('initial state is correct', () {
      expect(viewModel.state.value, 0);
      expect(viewModel.state.status, Status.initial);
    });

    test('increment increases value', () {
      viewModel.increment();

      expect(viewModel.state.value, 1);
      expect(viewModel.state.status, Status.success);
    });

    test('reset sets value to 0', () async {
      viewModel.increment();
      await viewModel.reset();

      expect(viewModel.state.value, 0);
      expect(viewModel.state.status, Status.success);
    });
  });
}
```

## Best Practices

1. **Single Responsibility**: Each ViewModel should handle one specific UI concern
2. **Immutable State**: Use Freezed to ensure state immutability and automatic copyWith methods
3. **Status Management**: Use the built-in status system for consistent loading and error states
4. **Lifecycle Methods**: Use `onInit()` for initialization logic
5. **Error Handling**: Always handle errors and update state accordingly
6. **Code Generation**: Run `dart pub run build_runner build` after creating or modifying Freezed classes
7. **Testing**: Write unit tests for your ViewModels to ensure reliability

## Dependencies

- `flutter_riverpod`: State management foundation
- `freezed_annotation`: Annotations for code generation
- `logger`: Debug logging capabilities

## Dev Dependencies

- `freezed`: Code generation for immutable classes
- `build_runner`: Build system for code generation
- `json_serializable`: JSON serialization support (optional)

## License

This package is part of the Wing Career Mobile project.
