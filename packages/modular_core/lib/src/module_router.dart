import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// A simple base class for module routers providing consistent structure
///
/// Example usage:
/// ```dart
/// class PostRouter extends ModuleRouter {
///   @override
///   String get basePath => '/posts';
///
///   @override
///   List<RouteBase> get routes => [
///     GoRoute(
///       path: basePath,
///       name: 'list',
///       builder: (context, state) => const PostListView(),
///       routes: [
///         GoRoute(
///           path: ':id',
///           name: 'detail',
///           builder: (context, state) {
///             final id = state.pathParameters['id']!;
///             return PostDetailView(postId: int.parse(id));
///           },
///         ),
///       ],
///     ),
///   ];
/// }
/// ```
@immutable
abstract class ModuleRouter {
  const ModuleRouter();

  /// The base path for this module (e.g., '/posts', '/auth', '/products')
  String get basePath;

  /// The routes provided by this module
  List<RouteBase> get routes;
}
