import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

/// Application configuration interface for modules
///
/// This abstract class provides access to environment settings, feature flags,
/// and other app-wide configuration values using flutter_dotenv.
///
/// Example implementation:
/// ```dart
/// class AppConfigImpl extends AppConfig {
///   AppConfigImpl({Map<String, bool>? featureFlags}) : super(featureFlags: featureFlags);
///
///   @override
///   Environment get environment => Environment.current;
///
///   @override
///   String get apiBaseUrl => getConfigValue('API_BASE_URL') ?? 'https://api.example.com';
/// }
/// ```
abstract class AppConfig {
  final Map<String, bool> _featureFlags;

  /// Creates an AppConfig instance with optional feature flags
  AppConfig({Map<String, bool>? featureFlags})
    : _featureFlags = featureFlags ?? {};

  /// Load environment variables from .env file
  ///
  /// Call this during app initialization to load the .env file.
  /// The file should be added to assets in pubspec.yaml.
  Future<void> loadEnvVariables(String envFileName) async {
    try {
      await dotenv.load(fileName: envFileName);
    } catch (e) {
      // Fallback to default .env file
      try {
        await dotenv.load(fileName: '.env');
      } catch (e) {
        // Continue without env variables if file doesn't exist
      }
    }
  }

  /// Get configuration value by key with optional default
  T? getConfigValue<T>(String key, {T? defaultValue}) {
    // get the value from the envVariables
    final value = envVariables[key];
    if (value == null) return defaultValue;

    // Type conversion
    if (T == String) return value as T;
    if (T == bool) return _parseBool(value) as T?;
    if (T == int) return int.tryParse(value) as T?;
    if (T == double) return double.tryParse(value) as T?;

    return defaultValue;
  }

  /// Get boolean value using flutter_dotenv's built-in method
  bool getBoolValue(String key, {bool fallback = false}) {
    return dotenv.getBool(key, fallback: fallback);
  }

  /// Get integer value using flutter_dotenv's built-in method
  int getIntValue(String key, {int fallback = 0}) {
    return dotenv.getInt(key, fallback: fallback);
  }

  /// Get double value using flutter_dotenv's built-in method
  double getDoubleValue(String key, {double fallback = 0.0}) {
    return dotenv.getDouble(key, fallback: fallback);
  }

  /// Get required value (throws if not found)
  String getRequiredValue(String key, {String? fallback}) {
    return dotenv.get(key, fallback: fallback);
  }

  /// Maybe get value (returns null if not found)
  String? getMaybeValue(String key) {
    return dotenv.maybeGet(key);
  }

  /// Get all loaded environment variables
  Map<String, String> get envVariables => Map.unmodifiable(dotenv.env);

  /// Load test environment variables (for testing)
  void loadTestEnvironment(String envContent) {
    dotenv.testLoad(fileInput: envContent);
  }

  /// Helper method to parse boolean values
  bool? _parseBool(String value) {
    final lowerValue = value.toLowerCase();
    if (lowerValue == 'true' || lowerValue == '1') return true;
    if (lowerValue == 'false' || lowerValue == '0') return false;
    return null;
  }

  /// Get feature flags (protected access for subclasses)
  @protected
  Map<String, bool> get featureFlags => Map.unmodifiable(_featureFlags);

  // Abstract methods that concrete implementations must provide
  String get apiBaseUrl;
  String get appName;
  bool get isDebugMode;

  bool isFeatureEnabled(String featureName) {
    // Check explicit feature flags first
    if (featureFlags.containsKey(featureName)) {
      return featureFlags[featureName]!;
    }

    // Check environment variables with FEATURE_ prefix
    final envKey = 'FEATURE_${featureName.toUpperCase()}';
    return getBoolValue(envKey, fallback: false);
  }

  @override
  String toString() {
    return 'AppConfig(apiBaseUrl: $apiBaseUrl, appName: $appName, isDebugMode: $isDebugMode, featureFlags: $featureFlags, envVariables: $envVariables)';
  }
}
