import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';
import 'package:viewmodel/viewmodel.dart';

// Mock logger for testing
class MockLogger extends Logger {
  final List<LogEvent> logs = [];

  MockLogger() : super(output: null);

  @override
  void log(
    Level level,
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logs.add(LogEvent(level, message, error, stackTrace));
  }
}

class LogEvent {
  final Level level;
  final dynamic message;
  final Object? error;
  final StackTrace? stackTrace;

  LogEvent(this.level, this.message, this.error, this.stackTrace);

  @override
  String toString() => 'LogEvent(level: $level, message: $message)';
}

// Test state for provider testing
class TestState {
  final int value;
  final String message;

  const TestState({this.value = 0, this.message = 'initial'});

  TestState copyWith({int? value, String? message}) {
    return TestState(
      value: value ?? this.value,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TestState &&
        other.value == value &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(value, message);

  @override
  String toString() => 'TestState(value: $value, message: $message)';
}

// Test provider that can fail
class TestNotifier extends StateNotifier<TestState> {
  TestNotifier() : super(const TestState());

  void increment() {
    state = state.copyWith(value: state.value + 1, message: 'incremented');
  }

  void throwError() {
    throw Exception('Test error');
  }
}

void main() {
  group('ViewModelObserver', () {
    late MockLogger mockLogger;
    late ViewModelObserver observer;
    late ProviderContainer container;

    setUp(() {
      mockLogger = MockLogger();
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('constructor', () {
      test('should create with default settings', () {
        final observer = ViewModelObserver();

        expect(observer.logStateChanges, kDebugMode);
        expect(observer.logErrors, isTrue);
        expect(observer.logProviderLifecycle, isFalse);
        expect(observer.verbose, isFalse);
      });

      test('should create with custom settings', () {
        final observer = ViewModelObserver(
          logStateChanges: false,
          logErrors: false,
          logProviderLifecycle: true,
          verbose: true,
          logger: mockLogger,
        );

        expect(observer.logStateChanges, isFalse);
        expect(observer.logErrors, isFalse);
        expect(observer.logProviderLifecycle, isTrue);
        expect(observer.verbose, isTrue);
      });

      test('should use provided logger', () {
        final observer = ViewModelObserver(logger: mockLogger);
        expect(observer, isNotNull);
      });
    });

    group('provider lifecycle logging', () {
      setUp(() {
        observer = ViewModelObserver(
          logProviderLifecycle: true,
          logger: mockLogger,
        );
        container = ProviderContainer(observers: [observer]);
      });

      test('should log provider addition when enabled', () {
        final provider = StateNotifierProvider<TestNotifier, TestState>(
          (ref) => TestNotifier(),
        );

        // Access the provider to trigger creation
        container.read(provider);

        expect(mockLogger.logs, isNotEmpty);
        expect(
          mockLogger.logs.any(
            (log) =>
                log.level == Level.debug &&
                log.message.toString().contains('Provider ADDED'),
          ),
          isTrue,
        );
      });

      test('should log provider disposal when enabled', () {
        final provider = StateNotifierProvider<TestNotifier, TestState>(
          (ref) => TestNotifier(),
        );

        // Access and then dispose
        container.read(provider);
        mockLogger.logs.clear();

        container.dispose();

        expect(
          mockLogger.logs.any(
            (log) =>
                log.level == Level.info &&
                log.message.toString().contains('Provider DISPOSED'),
          ),
          isTrue,
        );
      });

      test('should not log provider lifecycle when disabled', () {
        observer = ViewModelObserver(
          logProviderLifecycle: false,
          logger: mockLogger,
        );
        container.dispose();
        container = ProviderContainer(observers: [observer]);

        final provider = StateNotifierProvider<TestNotifier, TestState>(
          (ref) => TestNotifier(),
        );

        container.read(provider);

        expect(
          mockLogger.logs.where(
            (log) => log.message.toString().contains('Provider ADDED'),
          ),
          isEmpty,
        );
      });
    });

    group('state change logging', () {
      setUp(() {
        observer = ViewModelObserver(logStateChanges: true, logger: mockLogger);
        container = ProviderContainer(observers: [observer]);
      });

      test('should log state updates when enabled', () {
        final provider = StateNotifierProvider<TestNotifier, TestState>(
          (ref) => TestNotifier(),
        );

        final notifier = container.read(provider.notifier);
        mockLogger.logs.clear();

        notifier.increment();

        expect(
          mockLogger.logs.any(
            (log) =>
                log.level == Level.debug &&
                log.message.toString().contains('Provider UPDATED'),
          ),
          isTrue,
        );
      });

      test('should log verbose state updates when verbose enabled', () {
        observer = ViewModelObserver(
          logStateChanges: true,
          verbose: true,
          logger: mockLogger,
        );
        container.dispose();
        container = ProviderContainer(observers: [observer]);

        final provider = StateNotifierProvider<TestNotifier, TestState>(
          (ref) => TestNotifier(),
        );

        final notifier = container.read(provider.notifier);
        mockLogger.logs.clear();

        notifier.increment();

        final updateLog = mockLogger.logs.firstWhere(
          (log) => log.message.toString().contains('Provider UPDATED'),
        );

        expect(updateLog.message.toString(), contains('Previous:'));
        expect(updateLog.message.toString(), contains('New:'));
      });

      test('should not log state changes when disabled', () {
        observer = ViewModelObserver(
          logStateChanges: false,
          logger: mockLogger,
        );
        container.dispose();
        container = ProviderContainer(observers: [observer]);

        final provider = StateNotifierProvider<TestNotifier, TestState>(
          (ref) => TestNotifier(),
        );

        final notifier = container.read(provider.notifier);
        mockLogger.logs.clear();

        notifier.increment();

        expect(
          mockLogger.logs.where(
            (log) => log.message.toString().contains('Provider UPDATED'),
          ),
          isEmpty,
        );
      });
    });

    group('error logging', () {
      setUp(() {
        observer = ViewModelObserver(logErrors: true, logger: mockLogger);
        container = ProviderContainer(observers: [observer]);
      });

      test('should log provider errors when enabled', () {
        final provider = Provider<String>((ref) {
          throw Exception('Test provider error');
        });

        expect(() => container.read(provider), throwsA(isA<Exception>()));

        expect(
          mockLogger.logs.any(
            (log) =>
                log.level == Level.error &&
                log.message.toString().contains('Provider ERROR'),
          ),
          isTrue,
        );
      });

      test('should not log errors when disabled', () {
        observer = ViewModelObserver(logErrors: false, logger: mockLogger);
        container.dispose();
        container = ProviderContainer(observers: [observer]);

        final provider = Provider<String>((ref) {
          throw Exception('Test provider error');
        });

        expect(() => container.read(provider), throwsA(isA<Exception>()));

        expect(
          mockLogger.logs.where(
            (log) => log.message.toString().contains('Provider ERROR'),
          ),
          isEmpty,
        );
      });
    });

    group('integration with actual ViewModels', () {
      test('should work with custom ViewModels', () {
        observer = ViewModelObserver(
          logStateChanges: true,
          logProviderLifecycle: true,
          logger: mockLogger,
        );
        container = ProviderContainer(observers: [observer]);

        // Create a simple ViewModel for testing
        final provider = StateNotifierProvider<TestNotifier, TestState>(
          (ref) => TestNotifier(),
        );

        final notifier = container.read(provider.notifier);
        mockLogger.logs.clear();

        notifier.increment();

        // Should have logged the state change
        expect(
          mockLogger.logs.any(
            (log) => log.message.toString().contains('Provider UPDATED'),
          ),
          isTrue,
        );
      });
    });

    group('performance', () {
      test(
        'should not significantly impact performance when logging disabled',
        () {
          observer = ViewModelObserver(
            logStateChanges: false,
            logErrors: false,
            logProviderLifecycle: false,
            logger: mockLogger,
          );
          container = ProviderContainer(observers: [observer]);

          final provider = StateNotifierProvider<TestNotifier, TestState>(
            (ref) => TestNotifier(),
          );

          final notifier = container.read(provider.notifier);
          final stopwatch = Stopwatch()..start();

          // Perform many state changes
          for (int i = 0; i < 1000; i++) {
            notifier.increment();
          }

          stopwatch.stop();

          // Should complete quickly and no logs should be generated
          expect(stopwatch.elapsedMilliseconds, lessThan(1000));
          expect(mockLogger.logs, isEmpty);
        },
      );
    });
  });
}
