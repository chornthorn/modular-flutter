import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import 'module_base.dart';

/// Abstract base class for observing modular system events
///
/// Implement this class to create custom observers for monitoring
/// module lifecycle events, dependency registrations, and routing activities.
abstract class ModularObserver {
  /// Called when a module is registered
  void onModuleRegistered(Module module) {}

  /// Called when a module registration fails
  void onModuleRegistrationFailed(
    Module module,
    Object error,
    StackTrace stackTrace,
  ) {}

  /// Called when a module is unregistered
  void onModuleUnregistered(Type moduleType) {}

  /// Called when module dependency registration starts
  void onDependencyRegistrationStarted(Module module) {}

  /// Called when module dependency registration completes
  void onDependencyRegistrationCompleted(Module module) {}

  /// Called when module dependency registration fails
  void onDependencyRegistrationFailed(
    Module module,
    Object error,
    StackTrace stackTrace,
  ) {}

  /// Called when a dependency is registered
  void onDependencyRegistered(Type serviceType, String registrationMethod) {}

  /// Called when routes are collected from a module
  void onRoutesCollected(Module module, List<RouteBase> routes) {}

  /// Called when route collection fails
  void onRouteCollectionFailed(
    Module module,
    Object error,
    StackTrace stackTrace,
  ) {}

  /// Called when the modular system is initialized
  void onModularSystemInitialized() {}

  /// Called when the modular system initialization fails
  void onModularSystemInitializationFailed(
    Object error,
    StackTrace stackTrace,
  ) {}

  /// Called when a service is resolved from the container
  void onServiceResolved(Type serviceType) {}

  /// Called when service resolution fails
  void onServiceResolutionFailed(
    Type serviceType,
    Object error,
    StackTrace stackTrace,
  ) {}

  /// Called when the modular system is reset
  void onModularSystemReset() {}
}

/// Default console logger implementation of ModularObserver
class ConsoleModularObserver extends ModularObserver {
  final bool enableDebugLogs;
  final bool enableVerboseLogs;
  final String logPrefix;

  ConsoleModularObserver({
    this.enableDebugLogs = true,
    this.enableVerboseLogs = false,
    this.logPrefix = '[MODULAR]',
  });

  void _log(String message, {LogLevel level = LogLevel.info}) {
    if (!enableDebugLogs && level == LogLevel.debug) return;
    if (!enableVerboseLogs && level == LogLevel.verbose) return;

    final timestamp = DateTime.now().toIso8601String();
    final levelStr = level.name.toUpperCase();
    final fullMessage = '$logPrefix [$timestamp] [$levelStr] $message';

    switch (level) {
      case LogLevel.error:
        developer.log(fullMessage, name: 'ModularObserver', level: 1000);
        // if (kDebugMode) print('\x1B[31m$fullMessage\x1B[0m'); // Red
        break;
      case LogLevel.warning:
        developer.log(fullMessage, name: 'ModularObserver', level: 900);
        // if (kDebugMode) print('\x1B[33m$fullMessage\x1B[0m'); // Yellow
        break;
      case LogLevel.info:
        developer.log(fullMessage, name: 'ModularObserver', level: 800);
        // if (kDebugMode) print('\x1B[32m$fullMessage\x1B[0m'); // Green
        break;
      case LogLevel.debug:
        developer.log(fullMessage, name: 'ModularObserver', level: 700);
        // if (kDebugMode) print('\x1B[36m$fullMessage\x1B[0m'); // Cyan
        break;
      case LogLevel.verbose:
        developer.log(fullMessage, name: 'ModularObserver', level: 500);
        // if (kDebugMode) print('\x1B[37m$fullMessage\x1B[0m'); // White
        break;
    }
  }

  @override
  void onModuleRegistered(Module module) {
    _log(
      'Module registered: ${module.runtimeType} (${module.moduleName})',
      level: LogLevel.info,
    );
  }

  @override
  void onModuleRegistrationFailed(
    Module module,
    Object error,
    StackTrace stackTrace,
  ) {
    _log(
      'Module registration failed: ${module.runtimeType} - $error',
      level: LogLevel.error,
    );
  }

  @override
  void onModuleUnregistered(Type moduleType) {
    _log('Module unregistered: $moduleType', level: LogLevel.info);
  }

  @override
  void onDependencyRegistrationStarted(Module module) {
    _log(
      'Dependency registration started: ${module.runtimeType}',
      level: LogLevel.debug,
    );
  }

  @override
  void onDependencyRegistrationCompleted(Module module) {
    _log(
      'Dependency registration completed: ${module.runtimeType}',
      level: LogLevel.debug,
    );
  }

  @override
  void onDependencyRegistrationFailed(
    Module module,
    Object error,
    StackTrace stackTrace,
  ) {
    _log(
      'Dependency registration failed: ${module.runtimeType} - $error',
      level: LogLevel.error,
    );
  }

  @override
  void onDependencyRegistered(Type serviceType, String registrationMethod) {
    _log(
      'Dependency registered: $serviceType ($registrationMethod)',
      level: LogLevel.verbose,
    );
  }

  @override
  void onRoutesCollected(Module module, List<RouteBase> routes) {
    _log(
      'Routes collected: ${module.runtimeType} (${routes.length} routes)',
      level: LogLevel.debug,
    );
  }

  @override
  void onRouteCollectionFailed(
    Module module,
    Object error,
    StackTrace stackTrace,
  ) {
    _log(
      'Route collection failed: ${module.runtimeType} - $error',
      level: LogLevel.error,
    );
  }

  @override
  void onModularSystemInitialized() {
    _log('Modular system initialized successfully', level: LogLevel.info);
  }

  @override
  void onModularSystemInitializationFailed(
    Object error,
    StackTrace stackTrace,
  ) {
    _log('Modular system initialization failed: $error', level: LogLevel.error);
  }

  @override
  void onServiceResolved(Type serviceType) {
    _log('Service resolved: $serviceType', level: LogLevel.verbose);
  }

  @override
  void onServiceResolutionFailed(
    Type serviceType,
    Object error,
    StackTrace stackTrace,
  ) {
    _log(
      'Service resolution failed: $serviceType - $error',
      level: LogLevel.error,
    );
  }

  @override
  void onModularSystemReset() {
    _log('Modular system reset', level: LogLevel.info);
  }
}

/// Log levels for the modular observer
enum LogLevel { error, warning, info, debug, verbose }

/// Observer manager for handling multiple observers
class ModularObserverManager {
  static final ModularObserverManager _instance =
      ModularObserverManager._internal();
  factory ModularObserverManager() => _instance;
  ModularObserverManager._internal();

  final List<ModularObserver> _observers = [];

  /// Add an observer to the manager
  void addObserver(ModularObserver observer) {
    if (!_observers.contains(observer)) {
      _observers.add(observer);
    }
  }

  /// Remove an observer from the manager
  void removeObserver(ModularObserver observer) {
    _observers.remove(observer);
  }

  /// Clear all observers
  void clearObservers() {
    _observers.clear();
  }

  /// Get all registered observers
  List<ModularObserver> get observers => List.unmodifiable(_observers);

  // Observer notification methods
  void notifyModuleRegistered(Module module) {
    for (final observer in _observers) {
      try {
        observer.onModuleRegistered(module);
      } catch (e) {
        // Ignore observer errors to prevent cascade failures
        if (kDebugMode) {
          print('Observer error in onModuleRegistered: $e');
        }
      }
    }
  }

  void notifyModuleRegistrationFailed(
    Module module,
    Object error,
    StackTrace stackTrace,
  ) {
    for (final observer in _observers) {
      try {
        observer.onModuleRegistrationFailed(module, error, stackTrace);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onModuleRegistrationFailed: $e');
        }
      }
    }
  }

  void notifyModuleUnregistered(Type moduleType) {
    for (final observer in _observers) {
      try {
        observer.onModuleUnregistered(moduleType);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onModuleUnregistered: $e');
        }
      }
    }
  }

  void notifyDependencyRegistrationStarted(Module module) {
    for (final observer in _observers) {
      try {
        observer.onDependencyRegistrationStarted(module);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onDependencyRegistrationStarted: $e');
        }
      }
    }
  }

  void notifyDependencyRegistrationCompleted(Module module) {
    for (final observer in _observers) {
      try {
        observer.onDependencyRegistrationCompleted(module);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onDependencyRegistrationCompleted: $e');
        }
      }
    }
  }

  void notifyDependencyRegistrationFailed(
    Module module,
    Object error,
    StackTrace stackTrace,
  ) {
    for (final observer in _observers) {
      try {
        observer.onDependencyRegistrationFailed(module, error, stackTrace);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onDependencyRegistrationFailed: $e');
        }
      }
    }
  }

  void notifyDependencyRegistered(Type serviceType, String registrationMethod) {
    for (final observer in _observers) {
      try {
        observer.onDependencyRegistered(serviceType, registrationMethod);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onDependencyRegistered: $e');
        }
      }
    }
  }

  void notifyRoutesCollected(Module module, List<RouteBase> routes) {
    for (final observer in _observers) {
      try {
        observer.onRoutesCollected(module, routes);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onRoutesCollected: $e');
        }
      }
    }
  }

  void notifyRouteCollectionFailed(
    Module module,
    Object error,
    StackTrace stackTrace,
  ) {
    for (final observer in _observers) {
      try {
        observer.onRouteCollectionFailed(module, error, stackTrace);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onRouteCollectionFailed: $e');
        }
      }
    }
  }

  void notifyModularSystemInitialized() {
    for (final observer in _observers) {
      try {
        observer.onModularSystemInitialized();
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onModularSystemInitialized: $e');
        }
      }
    }
  }

  void notifyModularSystemInitializationFailed(
    Object error,
    StackTrace stackTrace,
  ) {
    for (final observer in _observers) {
      try {
        observer.onModularSystemInitializationFailed(error, stackTrace);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onModularSystemInitializationFailed: $e');
        }
      }
    }
  }

  void notifyServiceResolved(Type serviceType) {
    for (final observer in _observers) {
      try {
        observer.onServiceResolved(serviceType);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onServiceResolved: $e');
        }
      }
    }
  }

  void notifyServiceResolutionFailed(
    Type serviceType,
    Object error,
    StackTrace stackTrace,
  ) {
    for (final observer in _observers) {
      try {
        observer.onServiceResolutionFailed(serviceType, error, stackTrace);
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onServiceResolutionFailed: $e');
        }
      }
    }
  }

  void notifyModularSystemReset() {
    for (final observer in _observers) {
      try {
        observer.onModularSystemReset();
      } catch (e) {
        if (kDebugMode) {
          print('Observer error in onModularSystemReset: $e');
        }
      }
    }
  }
}
