import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'app_config.dart';
import 'module_router.dart';

/// Base class for all modules providing dependency injection and routing
///
/// This abstract class defines the contract that all feature modules must
/// implement to integrate with the application's dependency injection
/// container and routing system.
///
/// Example usage:
/// ```dart
/// class AuthModule extends Module<AuthRouter> {
///   @override
///   AuthRouter createRouter() => AuthRouter();
///
///   @override
///   void registerDependencies(GetIt getIt, AppConfig appConfig) {
///     // Register auth-specific dependencies using config
///     getIt.registerLazySingleton<AuthRepository>(
///       () => AuthRepositoryImpl(
///         apiBaseUrl: appConfig.apiBaseUrl,
///         isDebugMode: appConfig.isDebugMode,
///       ),
///     );
///   }
/// }
/// ```
abstract class Module<T extends ModuleRouter> {
  T? _router;

  /// Get the router instance for this module
  T get router => _router ??= createRouter();

  /// Routes provided by this module
  ///
  /// Returns the routes from the module's router. Override [createRouter]
  /// to provide your custom router implementation.
  List<RouteBase> get routes => router.routes;

  /// Module name from the router
  ///
  /// Returns the module name as defined by the router.
  String get moduleName;

  /// Create the router instance for this module
  ///
  /// This method should return a new instance of the module's router.
  /// It will be called lazily when the router is first accessed.
  T createRouter();

  /// Register all dependencies for this module
  ///
  /// This method should register all services, repositories, use cases,
  /// and other dependencies that this module provides to the dependency
  /// injection container.
  ///
  /// The [getIt] parameter is the application's service locator instance
  /// where dependencies should be registered.
  /// The [appConfig] parameter provides access to application configuration
  /// that modules may need during dependency registration.
  void registerDependencies(GetIt getIt, AppConfig appConfig);
}
