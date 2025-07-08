/// A library for managing modules in a modular architecture.
///
/// This library provides a set of classes and utilities for managing modules in a
/// modular architecture. It includes classes for managing application configuration,
/// modules, and their dependencies.
///
/// The main classes are:
///
/// - [AppConfig]: Manages application configuration.
/// - [Module]: Represents a module in the application.
/// - [ModuleRouter]: Manages the routes for a module.
/// - [Result]: A result type for handling operations with success or failure.
///
library;

export 'package:go_router/go_router.dart';

export 'src/app_config.dart';
export 'src/modular_observer.dart';
export 'src/module_base.dart' show Module;
export 'src/module_manager_base.dart';
export 'src/module_registry.dart';
export 'src/module_router.dart';
export 'src/result.dart';
export 'src/service_locator.dart';
