// ignore_for_file: override_on_non_overriding_member

import 'package:test/test.dart';
import 'package:viewmodel/viewmodel.dart';

// Test UiState implementation
class TestUiState extends UiState<TestUiState> {
  final int counter;
  @override
  final Status status;
  @override
  final String? message;
  @override
  final String? errorMessage;

  const TestUiState({
    this.counter = 0,
    this.status = Status.initial,
    this.message,
    this.errorMessage,
  });

  @override
  TestUiState get loading => copyWith(status: Status.loading);

  TestUiState copyWith({
    int? counter,
    Status? status,
    String? message,
    String? errorMessage,
  }) {
    return TestUiState(
      counter: counter ?? this.counter,
      status: status ?? this.status,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TestUiState &&
        other.counter == counter &&
        other.status == status &&
        other.message == message &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => Object.hash(counter, status, message, errorMessage);
}

// Test ViewModel implementation
class TestViewModel extends ViewModel<TestUiState> {
  TestViewModel([TestUiState? initialState])
    : super(initialState ?? const TestUiState());

  bool onInitCalled = false;
  int onInitCallCount = 0;

  @override
  Future<void> onInit() async {
    onInitCalled = true;
    onInitCallCount++;
  }

  void increment() {
    state = state.copyWith(
      counter: state.counter + 1,
      status: Status.success,
      message: 'Incremented to ${state.counter + 1}',
    );
  }

  void decrement() {
    state = state.copyWith(
      counter: state.counter - 1,
      status: Status.success,
      message: 'Decremented to ${state.counter - 1}',
    );
  }

  Future<void> incrementAsync() async {
    state = state.loading;

    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 10));

    state = state.copyWith(
      counter: state.counter + 1,
      status: Status.success,
      message: 'Async increment completed',
    );
  }

  void setError(String error) {
    state = state.copyWith(status: Status.error, errorMessage: error);
  }

  void reset() {
    state = const TestUiState();
  }
}

void main() {
  group('ViewModel', () {
    late TestViewModel viewModel;

    setUp(() {
      viewModel = TestViewModel();
    });

    tearDown(() {
      viewModel.dispose();
    });

    group('initialization', () {
      test('should initialize with provided initial state', () {
        const initialState = TestUiState(counter: 5, status: Status.success);
        final vm = TestViewModel(initialState);

        expect(vm.state.counter, 5);
        expect(vm.state.status, Status.success);
        expect(vm.uiState.counter, 5);
        expect(vm.uiState.status, Status.success);

        vm.dispose();
      });

      test('should call onInit during construction', () {
        final vm = TestViewModel();
        expect(vm.onInitCalled, isTrue);
        expect(vm.onInitCallCount, 1);

        vm.dispose();
      });

      test('should only call onInit once', () {
        final vm = TestViewModel();
        expect(vm.onInitCallCount, 1);

        // onInit should not be called again
        vm.increment();
        expect(vm.onInitCallCount, 1);

        vm.dispose();
      });
    });

    group('state management', () {
      test('should provide access to state via state property', () {
        expect(viewModel.state, isA<TestUiState>());
        expect(viewModel.state.counter, 0);
        expect(viewModel.state.status, Status.initial);
      });

      test('should provide access to state via uiState property', () {
        expect(viewModel.uiState, isA<TestUiState>());
        expect(viewModel.uiState.counter, 0);
        expect(viewModel.uiState.status, Status.initial);
        expect(viewModel.uiState, equals(viewModel.state));
      });

      test('should update state correctly', () {
        expect(viewModel.state.counter, 0);

        viewModel.increment();

        expect(viewModel.state.counter, 1);
        expect(viewModel.state.status, Status.success);
        expect(viewModel.state.message, 'Incremented to 1');
      });

      test('should maintain state immutability', () {
        final originalState = viewModel.state;

        viewModel.increment();

        expect(originalState.counter, 0);
        expect(viewModel.state.counter, 1);
        expect(originalState, isNot(equals(viewModel.state)));
      });
    });

    group('state changes', () {
      test('should notify listeners on state change', () {
        var notificationCount = 0;
        TestUiState? lastState;

        viewModel.addListener((state) {
          notificationCount++;
          lastState = state;
        });

        expect(notificationCount, 0);

        viewModel.increment();

        expect(notificationCount, 1);
        expect(lastState?.counter, 1);
      });

      test('should handle multiple state changes', () {
        final states = <TestUiState>[];

        viewModel.addListener((state) {
          states.add(state);
        });

        viewModel.increment();
        viewModel.increment();
        viewModel.decrement();

        expect(states, hasLength(3));
        expect(states[0].counter, 1);
        expect(states[1].counter, 2);
        expect(states[2].counter, 1);
      });
    });

    group('async operations', () {
      test('should handle async state changes', () async {
        expect(viewModel.state.status, Status.initial);

        final future = viewModel.incrementAsync();

        // Should be loading during async operation
        expect(viewModel.state.status, Status.loading);

        await future;

        // Should be success after completion
        expect(viewModel.state.status, Status.success);
        expect(viewModel.state.counter, 1);
        expect(viewModel.state.message, 'Async increment completed');
      });
    });

    group('error handling', () {
      test('should handle error states', () {
        viewModel.setError('Something went wrong');

        expect(viewModel.state.status, Status.error);
        expect(viewModel.state.errorMessage, 'Something went wrong');
      });
    });

    group('reset functionality', () {
      test('should reset to initial state', () {
        viewModel.increment();
        viewModel.increment();
        expect(viewModel.state.counter, 2);

        viewModel.reset();

        expect(viewModel.state.counter, 0);
        expect(viewModel.state.status, Status.initial);
        expect(viewModel.state.message, isNull);
        expect(viewModel.state.errorMessage, isNull);
      });
    });

    group('disposal', () {
      test('should be disposable', () {
        expect(viewModel.mounted, isTrue);

        viewModel.dispose();

        expect(viewModel.mounted, isFalse);
      });

      test('should not allow state changes after disposal', () {
        viewModel.dispose();

        expect(() => viewModel.increment(), throwsA(isA<StateError>()));
      });
    });

    group('inheritance', () {
      test('should extend StateNotifier', () {
        expect(viewModel, isA<StateNotifier<TestUiState>>());
      });

      test('should work with Riverpod providers', () {
        // This test ensures the ViewModel can be used with StateNotifierProvider
        expect(viewModel.state, isA<TestUiState>());
        expect(viewModel.mounted, isTrue);
      });
    });
  });
}
