import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'app_config.dart';
import 'modular_observer.dart';
import 'module_base.dart';
import 'service_locator.dart';

/// A centralized registry for managing application modules
///
/// This class provides a single point of control for registering modules,
/// managing their dependencies, and collecting their routes. It ensures
/// proper initialization order and prevents duplicate registrations.
///
/// Example usage:
/// ```dart
/// void main() {
///   // Initialize the registry
///   final registry = ModuleRegistry();
///
///   // Register modules
///   registry
///     ..registerModule(AuthModule())
///     ..registerModule(ProductModule())
///     ..registerModule(PostModule());
///
///   // Initialize all dependencies
///   registry.initializeAll();
///
///   // Get all routes for router configuration
///   final routes = registry.getAllRoutes();
///
///   runApp(MyApp(routes: routes));
/// }
/// ```
class ModuleRegistry {
  final Map<Type, Module> _modules = {};
  final ServiceLocator _locator;
  final AppConfig _appConfig;
  final ModularObserverManager _observerManager = ModularObserverManager();
  bool _isInitialized = false;

  /// Creates a new module registry
  ///
  /// [locator] - Optional service locator instance. If not provided, uses GetIt.instance
  /// [appConfig] - Required application configuration instance
  ModuleRegistry({ServiceLocator? locator, required AppConfig appConfig})
    : _locator = locator ?? GetIt.instance,
      _appConfig = appConfig;

  /// Add an observer to monitor module lifecycle events
  void addObserver(ModularObserver observer) {
    _observerManager.addObserver(observer);
  }

  /// Remove an observer
  void removeObserver(ModularObserver observer) {
    _observerManager.removeObserver(observer);
  }

  /// Clear all observers
  void clearObservers() {
    _observerManager.clearObservers();
  }

  /// Get all registered observers
  List<ModularObserver> get observers => _observerManager.observers;

  /// Registers a module in the registry
  ///
  /// Throws [ModuleRegistrationException] if a module of the same type
  /// is already registered or if the registry has already been initialized.
  ///
  /// Returns the registry instance for method chaining.
  ModuleRegistry registerModule(Module module) {
    if (_isInitialized) {
      final error = ModuleRegistrationException(
        'Cannot register module ${module.runtimeType} after initialization',
      );
      _observerManager.notifyModuleRegistrationFailed(
        module,
        error,
        StackTrace.current,
      );
      throw error;
    }

    final moduleType = module.runtimeType;
    if (_modules.containsKey(moduleType)) {
      final error = ModuleRegistrationException(
        'Module of type $moduleType is already registered',
      );
      _observerManager.notifyModuleRegistrationFailed(
        module,
        error,
        StackTrace.current,
      );
      throw error;
    }

    _modules[moduleType] = module;
    _observerManager.notifyModuleRegistered(module);
    return this;
  }

  /// Registers multiple modules at once
  ///
  /// Returns the registry instance for method chaining.
  ModuleRegistry registerModules(List<Module> modules) {
    for (final module in modules) {
      registerModule(module);
    }
    return this;
  }

  /// Unregisters a module by type
  ///
  /// Throws [ModuleRegistrationException] if the registry has already
  /// been initialized.
  ///
  /// Returns true if the module was found and removed, false otherwise.
  bool unregisterModule<T extends Module>() {
    if (_isInitialized) {
      throw ModuleRegistrationException(
        'Cannot unregister module $T after initialization',
      );
    }

    final wasRemoved = _modules.remove(T) != null;
    if (wasRemoved) {
      _observerManager.notifyModuleUnregistered(T);
    }
    return wasRemoved;
  }

  /// Checks if a module of the specified type is registered
  bool isModuleRegistered<T extends Module>() {
    return _modules.containsKey(T);
  }

  /// Gets a registered module by type
  ///
  /// Returns null if no module of the specified type is registered.
  T? getModule<T extends Module>() {
    return _modules[T] as T?;
  }

  /// Gets all registered modules
  List<Module> getAllModules() {
    return List.unmodifiable(_modules.values);
  }

  /// Gets all module types that are registered
  List<Type> getRegisteredModuleTypes() {
    return List.unmodifiable(_modules.keys);
  }

  /// Initializes all registered modules by calling their registerDependencies method
  ///
  /// This should be called after all modules are registered and before
  /// the application starts using the registered dependencies.
  ///
  /// Throws [ModuleRegistrationException] if already initialized.
  void initializeAll() {
    if (_isInitialized) {
      throw ModuleRegistrationException(
        'Module registry has already been initialized',
      );
    }

    for (final module in _modules.values) {
      try {
        _observerManager.notifyDependencyRegistrationStarted(module);
        module.registerDependencies(_locator, _appConfig);
        _observerManager.notifyDependencyRegistrationCompleted(module);
      } catch (e, stackTrace) {
        _observerManager.notifyDependencyRegistrationFailed(
          module,
          e,
          stackTrace,
        );
        throw ModuleInitializationException(
          'Failed to initialize module ${module.runtimeType}: $e',
          module.runtimeType,
          e,
          stackTrace,
        );
      }
    }

    _isInitialized = true;
  }

  /// Collects and returns all routes from registered modules
  ///
  /// This method can be called before or after initialization.
  List<RouteBase> getAllRoutes() {
    final routes = <RouteBase>[];

    for (final module in _modules.values) {
      try {
        final moduleRoutes = module.routes;
        routes.addAll(moduleRoutes);
        _observerManager.notifyRoutesCollected(module, moduleRoutes);
      } catch (e, stackTrace) {
        _observerManager.notifyRouteCollectionFailed(module, e, stackTrace);
        throw ModuleRouteException(
          'Failed to get routes from module ${module.runtimeType}: $e',
          module.runtimeType,
          e,
          stackTrace,
        );
      }
    }

    return routes;
  }

  /// Gets routes from a specific module type
  ///
  /// Returns empty list if the module is not registered.
  List<RouteBase> getModuleRoutes<T extends Module>() {
    final module = getModule<T>();
    if (module == null) return [];

    try {
      final moduleRoutes = List<RouteBase>.from(module.routes);
      _observerManager.notifyRoutesCollected(module, moduleRoutes);
      return moduleRoutes;
    } catch (e, stackTrace) {
      _observerManager.notifyRouteCollectionFailed(module, e, stackTrace);
      throw ModuleRouteException(
        'Failed to get routes from module $T: $e',
        T,
        e,
        stackTrace,
      );
    }
  }

  /// Resets the registry to its initial state
  ///
  /// This will clear all registered modules and reset the initialization state.
  /// Useful for testing or when you need to reconfigure the application.
  ///
  /// **Warning**: This does not unregister dependencies from GetIt.
  /// You should manually reset GetIt if needed.
  void reset() {
    _modules.clear();
    _isInitialized = false;
    _observerManager.notifyModularSystemReset();
  }

  /// Gets the initialization status of the registry
  bool get isInitialized => _isInitialized;

  /// Gets the number of registered modules
  int get moduleCount => _modules.length;

  /// Gets the service locator instance being used by this registry
  ServiceLocator get locator => _locator;
}

/// Exception thrown when there are issues with module registration
class ModuleRegistrationException implements Exception {
  final String message;

  const ModuleRegistrationException(this.message);

  @override
  String toString() => 'ModuleRegistrationException: $message';
}

/// Exception thrown when module initialization fails
class ModuleInitializationException implements Exception {
  final String message;
  final Type moduleType;
  final Object originalError;
  final StackTrace stackTrace;

  const ModuleInitializationException(
    this.message,
    this.moduleType,
    this.originalError,
    this.stackTrace,
  );

  @override
  String toString() => 'ModuleInitializationException: $message';
}

/// Exception thrown when getting routes from a module fails
class ModuleRouteException implements Exception {
  final String message;
  final Type moduleType;
  final Object originalError;
  final StackTrace stackTrace;

  const ModuleRouteException(
    this.message,
    this.moduleType,
    this.originalError,
    this.stackTrace,
  );

  @override
  String toString() => 'ModuleRouteException: $message';
}
