import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// A custom [ProviderObserver] that logs state changes and errors for ViewModels.
///
/// This observer helps with debugging by logging state changes, error
/// handling, and provider lifecycle events. It can be configured to log
/// different levels of detail based on the current environment.
///
/// Usage:
/// ```dart
/// void main() {
///   runApp(
///     ViewModelScope(
///       observers: [ViewModelObserver()],
///       child: MyApp(),
///     ),
///   );
/// }
/// ```
class ViewModelObserver extends ProviderObserver {
  /// Creates a [ViewModelObserver] with configurable logging.
  ///
  /// - [logStateChanges]: Whether to log state changes
  /// - [logErrors]: Whether to log errors
  /// - [logProviderLifecycle]: Whether to log provider creation/disposal
  /// - [verbose]: Whether to log detailed information
  /// - [logger]: An optional custom logger instance
  ViewModelObserver({
    this.logStateChanges = kDebugMode,
    this.logErrors = true,
    this.logProviderLifecycle = false,
    this.verbose = false,
    Logger? logger,
  }) : _logger =
           logger ??
           Logger(
             printer: PrettyPrinter(
               methodCount: 0,
               errorMethodCount: 8,
               lineLength: 120,
               colors: true,
               printEmojis: true,
               dateTimeFormat: DateTimeFormat.none,
               noBoxingByDefault: false,
             ),
           );

  /// Whether to log state changes.
  final bool logStateChanges;

  /// Whether to log errors.
  final bool logErrors;

  /// Whether to log provider creation and disposal.
  final bool logProviderLifecycle;

  /// Whether to log detailed information.
  final bool verbose;

  /// The logger instance.
  final Logger _logger;

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (!logProviderLifecycle) return;

    _logger.d('⚡ Provider ADDED: ${provider.name ?? provider.runtimeType}');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (!logProviderLifecycle) return;

    _logger.i(
      '🗑️ Provider DISPOSED: ${provider.name ?? provider.runtimeType}',
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (!logStateChanges) return;

    if (verbose) {
      _logger.d('''
🔄 Provider UPDATED: ${provider.name ?? provider.runtimeType}
   Previous: $previousValue
   New: $newValue
''');
    } else {
      _logger.d(
        '🔄 Provider UPDATED: ${provider.name ?? provider.runtimeType}',
      );
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (!logErrors) return;

    _logger.e(
      '❌ Provider ERROR: ${provider.name ?? provider.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
