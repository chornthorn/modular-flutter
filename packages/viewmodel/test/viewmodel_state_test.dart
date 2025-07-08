// ignore_for_file: override_on_non_overriding_member
import 'package:test/test.dart';
import 'package:viewmodel/viewmodel.dart';

// Test implementation of UiState without Freezed
class TestUiState extends UiState<TestUiState> {
  final String value;
  @override
  final UiStatus uiStatus;
  @override
  final String? message;
  @override
  final String? errorMessage;

  const TestUiState({
    this.value = 'test',
    this.uiStatus = UiStatus.initial,
    this.message,
    this.errorMessage,
  });

  @override
  TestUiState get loading => copyWith(uiStatus: UiStatus.loading);

  TestUiState copyWith({
    String? value,
    UiStatus? uiStatus,
    String? message,
    String? errorMessage,
  }) {
    return TestUiState(
      value: value ?? this.value,
      uiStatus: uiStatus ?? this.uiStatus,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TestUiState &&
        other.value == value &&
        other.uiStatus == uiStatus &&
        other.message == message &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => Object.hash(value, uiStatus, message, errorMessage);

  @override
  String toString() {
    return 'TestUiState(value: $value, uiStatus: $uiStatus, message: $message, errorMessage: $errorMessage)';
  }
}

void main() {
  group('UiState', () {
    late TestUiState initialState;

    setUp(() {
      initialState = const TestUiState();
    });

    group('constructor', () {
      test('should create state with default values', () {
        expect(initialState.value, 'test');
        expect(initialState.uiStatus, UiStatus.initial);
        expect(initialState.message, isNull);
        expect(initialState.errorMessage, isNull);
      });

      test('should create state with custom values', () {
        final state = const TestUiState(
          value: 'custom',
          uiStatus: UiStatus.success,
          message: 'success message',
          errorMessage: 'error message',
        );

        expect(state.value, 'custom');
        expect(state.uiStatus, UiStatus.success);
        expect(state.message, 'success message');
        expect(state.errorMessage, 'error message');
      });
    });

    group('status convenience methods', () {
      test('isInitial should return true for initial status', () {
        final state = initialState.copyWith(uiStatus: UiStatus.initial);
        expect(state.isInitial, isTrue);
        expect(state.isLoading, isFalse);
        expect(state.isSuccess, isFalse);
        expect(state.isError, isFalse);
      });

      test('isLoading should return true for loading status', () {
        final state = initialState.copyWith(uiStatus: UiStatus.loading);
        expect(state.isLoading, isTrue);
        expect(state.isInitial, isFalse);
        expect(state.isSuccess, isFalse);
        expect(state.isError, isFalse);
      });

      test('isSuccess should return true for success status', () {
        final state = initialState.copyWith(uiStatus: UiStatus.success);
        expect(state.isSuccess, isTrue);
        expect(state.isInitial, isFalse);
        expect(state.isLoading, isFalse);
        expect(state.isError, isFalse);
      });

      test('isError should return true for error status', () {
        final state = initialState.copyWith(uiStatus: UiStatus.error);
        expect(state.isError, isTrue);
        expect(state.isInitial, isFalse);
        expect(state.isLoading, isFalse);
        expect(state.isSuccess, isFalse);
      });
    });

    group('loading getter', () {
      test('should return state with loading status', () {
        final state = const TestUiState(
          value: 'custom',
          uiStatus: UiStatus.success,
          message: 'original message',
          errorMessage: 'original error',
        );

        final loadingState = state.loading;

        expect(loadingState.uiStatus, UiStatus.loading);
        expect(loadingState.value, 'custom');
        expect(loadingState.message, 'original message');
        expect(loadingState.errorMessage, 'original error');
      });
    });

    group('copyWith method', () {
      test('should support copyWith method', () {
        final state = initialState.copyWith(
          value: 'updated',
          uiStatus: UiStatus.success,
          message: 'done',
        );

        expect(state.value, 'updated');
        expect(state.uiStatus, UiStatus.success);
        expect(state.message, 'done');
        expect(state.errorMessage, isNull);
      });

      test('should preserve unchanged values in copyWith', () {
        final original = const TestUiState(
          value: 'original',
          uiStatus: UiStatus.success,
          message: 'original message',
          errorMessage: 'original error',
        );

        final updated = original.copyWith(value: 'updated');

        expect(updated.value, 'updated');
        expect(updated.uiStatus, UiStatus.success);
        expect(updated.message, 'original message');
        expect(updated.errorMessage, 'original error');
      });
    });

    group('equality and hash code', () {
      test('should support equality comparison', () {
        final state1 = const TestUiState(value: 'test');
        final state2 = const TestUiState(value: 'test');
        final state3 = const TestUiState(value: 'different');

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });

      test('should support hashCode properly', () {
        final state1 = const TestUiState(value: 'test');
        final state2 = const TestUiState(value: 'test');
        final state3 = const TestUiState(value: 'different');

        expect(state1.hashCode, equals(state2.hashCode));
        expect(state1.hashCode, isNot(equals(state3.hashCode)));
      });
    });

    group('toString', () {
      test('should have proper toString representation', () {
        final state = const TestUiState(
          value: 'test',
          uiStatus: UiStatus.success,
          message: 'success',
        );

        final stringRepresentation = state.toString();
        expect(stringRepresentation, contains('TestUiState'));
        expect(stringRepresentation, contains('test'));
        expect(stringRepresentation, contains('UiStatus.success'));
        expect(stringRepresentation, contains('success'));
      });
    });

    group('immutability', () {
      test('should be immutable', () {
        final state = const TestUiState(value: 'original');
        final modifiedState = state.copyWith(value: 'modified');

        expect(state.value, 'original');
        expect(modifiedState.value, 'modified');
        expect(state, isNot(equals(modifiedState)));
      });
    });
  });
}
