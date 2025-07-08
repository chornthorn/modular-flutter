import 'package:go_router/go_router.dart';

import 'app_config.dart';
import 'module_base.dart';
import 'module_registry.dart';
import 'result.dart';
import 'service_locator.dart';

/// Base class for module managers providing centralized module management
///
/// This abstract class provides a standardized way to manage application modules
/// with proper error handling, validation, and singleton pattern implementation.
/// It follows the modular_core patterns for Result-based error handling and
/// provides a consistent interface for module registration and initialization.
///
/// The singleton pattern is built-in, so concrete implementations only need to
/// implement the createModules() method:
///
/// Example implementation:
/// ```dart
/// class AppModuleManager extends ModuleManagerBase<AppModuleManager> {
///   AppModuleManager._(AppConfig appConfig) : super(appConfig: appConfig);
///
///   static AppModuleManager getInstance(AppConfig appConfig) =>
///       ModuleManagerBase.getInstance<AppModuleManager>(
///         appConfig,
///         (config) => AppModuleManager._(config),
///       );
///
///   @override
///   List<ModuleBase> registerModules() => [
///     AuthModule(),
///     ProductModule(),
///     PostModule(),
///   ];
/// }
/// ```
abstract class ModuleManagerBase<T extends ModuleManagerBase<T>> {
  static final Map<Type, ModuleManagerBase> _instances = {};

  late final ModuleRegistry _registry;
  bool _isInitialized = false;

  /// Creates a new module manager base
  ///
  /// [locator] - Optional service locator instance. If not provided, uses GetIt.instance
  /// [appConfig] - Required application configuration instance
  ModuleManagerBase({ServiceLocator? locator, required AppConfig appConfig}) {
    _registry = ModuleRegistry(locator: locator, appConfig: appConfig);
  }

  /// Generic singleton factory method
  ///
  /// This method provides a type-safe singleton implementation that can be used
  /// by all concrete module manager implementations.
  ///
  /// [appConfig] - Required application configuration instance
  /// [factory] - Factory function to create new instances of the concrete type
  static M getInstance<M extends ModuleManagerBase<M>>(
    AppConfig appConfig,
    M Function(AppConfig) factory,
  ) {
    return (_instances[M] ??= factory(appConfig)) as M;
  }

  /// Reset all singleton instances
  ///
  /// This method clears all cached singleton instances. Useful for testing
  /// or when you need to completely reset the application state.
  ///
  /// **Warning**: This does not unregister dependencies from GetIt.
  static void resetAllInstances() {
    for (final instance in _instances.values) {
      instance.reset();
    }
    _instances.clear();
  }

  /// Create the list of modules to be managed
  ///
  /// This method should return all modules that need to be registered
  /// and initialized by this manager.
  List<Module> registerModules();

  /// Initialize all modules with proper error handling
  ///
  /// This method registers all modules and initializes their dependencies.
  /// Returns a Result indicating success or failure with detailed error information.
  Future<Result<void, Exception>> initializeModules() async {
    try {
      if (_isInitialized) {
        return Ok(null);
      }

      final modules = registerModules();

      if (modules.isEmpty) {
        return Err(Exception('No modules provided for initialization'));
      }

      // Register all modules
      final registerResult = _registerModules(modules);
      if (registerResult.isErr()) {
        return Err(registerResult.unwrapErr());
      }

      // Initialize all registered modules
      final initResult = _initializeRegistry();
      if (initResult.isErr()) {
        return Err(initResult.unwrapErr());
      }

      _isInitialized = true;
      return Ok(null);
    } catch (error) {
      return Err(Exception('Failed to initialize modules: $error'));
    }
  }

  /// Get all routes from registered modules
  ///
  /// Returns a Result containing all routes or an error if route collection fails.
  Result<List<RouteBase>, Exception> getAllRoutes() {
    try {
      final routes = _registry.getAllRoutes();
      return Ok(routes);
    } catch (error) {
      return Err(Exception('Failed to collect routes: $error'));
    }
  }

  /// Check if a specific module type is registered
  ///
  /// Returns true if the module is registered, false otherwise.
  bool isModuleRegistered<M extends Module>() {
    return _registry.isModuleRegistered<M>();
  }

  /// Get a specific module instance
  ///
  /// Returns a Result containing the module instance or an error if not found.
  Result<M, Exception> getModule<M extends Module>() {
    try {
      final module = _registry.getModule<M>();
      if (module == null) {
        return Err(Exception('Module of type $Module is not registered'));
      }
      return Ok(module);
    } catch (error) {
      return Err(Exception('Failed to get module $Module: $error'));
    }
  }

  /// Get all registered modules
  ///
  /// Returns a Result containing all registered modules.
  Result<List<Module>, Exception> getAllModules() {
    try {
      final modules = _registry.getAllModules();
      return Ok(modules);
    } catch (error) {
      return Err(Exception('Failed to get all modules: $error'));
    }
  }

  /// Get the number of registered modules
  int get moduleCount => _registry.moduleCount;

  /// Check if the manager has been initialized
  bool get isInitialized => _isInitialized;

  /// Get the underlying registry instance
  ///
  /// This is exposed for advanced use cases but should generally not be used directly.
  ModuleRegistry get registry => _registry;

  /// Reset the manager to its initial state
  ///
  /// This clears all registered modules and resets the initialization state.
  /// Useful for testing or when you need to reconfigure the application.
  ///
  /// **Warning**: This does not unregister dependencies from GetIt.
  void reset() {
    _registry.reset();
    _isInitialized = false;
  }

  /// Register modules with the registry
  Result<void, Exception> _registerModules(List<Module> modules) {
    try {
      _registry.registerModules(modules);
      return Ok(null);
    } on ModuleRegistrationException catch (e) {
      return Err(Exception('Failed to register modules: $e'));
    } catch (error) {
      return Err(Exception('Failed to register modules: $error'));
    }
  }

  /// Initialize the registry
  Result<void, Exception> _initializeRegistry() {
    try {
      _registry.initializeAll();
      return Ok(null);
    } on ModuleInitializationException catch (e) {
      return Err(Exception('Failed to initialize registry: $e'));
    } on ModuleRegistrationException catch (e) {
      return Err(Exception('Failed to initialize registry: $e'));
    } catch (error) {
      return Err(Exception('Failed to initialize registry: $error'));
    }
  }
}
