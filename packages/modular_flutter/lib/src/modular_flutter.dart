import 'package:flutter/material.dart';
import 'package:modular_core/modular_core.dart';

/// The main entry point for the modular architecture
///
/// This widget initializes the modular system and provides access to the router configuration.
class ModularApp extends StatefulWidget {
  /// List of modules to register
  final List<Module> modules;

  /// The child widget (typically your main app)
  final Widget child;

  /// widget to be displayed when the app is loading
  final Widget? loading;

  /// Optional app configuration
  final AppConfig? appConfig;

  /// Optional list of observers to monitor module lifecycle events
  final List<ModularObserver>? observers;

  const ModularApp({
    super.key,
    required this.modules,
    required this.child,
    this.loading,
    this.appConfig,
    this.observers,
  });

  @override
  State<ModularApp> createState() => _ModularAppState();
}

class _ModularAppState extends State<ModularApp> {
  late final ModuleRegistry _registry;
  late final GoRouter _router;
  bool _isInitialized = false;
  final ModularObserverManager _observerManager = ModularObserverManager();

  @override
  void initState() {
    super.initState();
    _initializeModules();
  }

  void _initializeModules() {
    try {
      // Add default console observer and any custom observers
      _observerManager.addObserver(ConsoleModularObserver());
      if (widget.observers != null) {
        for (final observer in widget.observers!) {
          _observerManager.addObserver(observer);
        }
      }

      // Create app config if not provided
      final appConfig = widget.appConfig ?? _DefaultAppConfig();

      // Create module registry
      _registry = ModuleRegistry(
        locator: ServiceLocator.instance,
        appConfig: appConfig,
      );

      // Transfer observers to registry
      for (final observer in _observerManager.observers) {
        _registry.addObserver(observer);
      }

      // Register all modules
      _registry.registerModules(widget.modules);

      // Initialize all dependencies
      _registry.initializeAll();

      // Collect all routes
      final routes = _registry.getAllRoutes();

      // Create router
      _router = GoRouter(routes: routes);

      // Make router available globally
      Modular._initialize(_router, _registry);

      // Notify observers of successful initialization
      _observerManager.notifyModularSystemInitialized();

      setState(() {
        _isInitialized = true;
      });
    } catch (e, stackTrace) {
      // Handle initialization errors
      _observerManager.notifyModularSystemInitializationFailed(e, stackTrace);
      debugPrint('Failed to initialize modular app: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialized) {
      return widget.child;
    }

    return MaterialApp(
      home: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

/// Global access point for the modular architecture
class Modular {
  static GoRouter? _router;
  static ModuleRegistry? _registry;
  static final ModularObserverManager _observerManager =
      ModularObserverManager();
  static bool _isPreRegistered = false;

  /// Register essential services before the app starts
  ///
  /// This method allows you to register core services that modules might depend on
  /// during their initialization phase.
  ///
  /// Example:
  /// ```dart
  /// void main() {
  ///   Modular.register((locator) async {
  ///     locator.registerLazySingleton<AppConfig>(() => DefaultAppConfig());
  ///     locator.registerLazySingleton<Logger>(() => Logger());
  ///   });
  ///   runApp(ModularApp(modules: [AppModule()], child: const ExampleApp()));
  /// }
  /// ```
  static Future<void> register(
    Future<void> Function(ServiceLocator locator) registration,
  ) async {
    if (_isPreRegistered) {
      throw Exception('Modular.register() can only be called once');
    }

    _isPreRegistered = true;

    try {
      // Add console observer for early logging
      _observerManager.addObserver(ConsoleModularObserver());

      // Run the registration and wait for completion
      await registration(ServiceLocator.instance);

      // Notify observers of successful pre-registration
      for (final observer in _observerManager.observers) {
        observer.onModularSystemInitialized();
      }
    } catch (error, stackTrace) {
      // Notify observers of failure
      for (final observer in _observerManager.observers) {
        observer.onModularSystemInitializationFailed(error, stackTrace);
      }
      rethrow;
    }
  }

  /// Initialize the modular system (called by ModularApp)
  static void _initialize(GoRouter router, ModuleRegistry registry) {
    _router = router;
    _registry = registry;
  }

  /// Get the router configuration for MaterialApp.router
  static GoRouter get routerConfig {
    if (_router == null) {
      throw Exception(
        'Modular not initialized. Make sure to wrap your app with ModularApp.',
      );
    }
    return _router!;
  }

  /// Get a registered module
  static T? getModule<T extends Module>() {
    return _registry?.getModule<T>();
  }

  /// Get a service from the dependency injection container
  static T get<T extends Object>() {
    try {
      final service = ServiceLocator.instance.get<T>();
      _observerManager.notifyServiceResolved(T);
      return service;
    } catch (e, stackTrace) {
      _observerManager.notifyServiceResolutionFailed(T, e, stackTrace);
      rethrow;
    }
  }

  /// Get a service from the dependency injection container asynchronously
  static Future<T> getAsync<T extends Object>() async {
    try {
      final service = await ServiceLocator.instance.getAsync<T>();
      _observerManager.notifyServiceResolved(T);
      return service;
    } catch (e, stackTrace) {
      _observerManager.notifyServiceResolutionFailed(T, e, stackTrace);
      rethrow;
    }
  }

  /// Check if a service is registered
  static bool isRegistered<T extends Object>() {
    return ServiceLocator.instance.isRegistered<T>();
  }

  /// Add an observer to monitor modular system events
  static void addObserver(ModularObserver observer) {
    _observerManager.addObserver(observer);
    _registry?.addObserver(observer);
  }

  /// Remove an observer
  static void removeObserver(ModularObserver observer) {
    _observerManager.removeObserver(observer);
    _registry?.removeObserver(observer);
  }

  /// Reset the modular system (useful for testing)
  static void reset() {
    _observerManager.notifyModularSystemReset();
    _router = null;
    _registry = null;
    _isPreRegistered = false;
    ServiceLocator.instance.reset();
  }
}

/// Default app configuration implementation
class _DefaultAppConfig extends AppConfig {
  @override
  String get apiBaseUrl => 'https://api.example.com';

  @override
  String get appName => 'Modular App';

  @override
  bool get isDebugMode => true;
}
