import 'package:modular_flutter/modular_flutter.dart';

import 'pages/post_details_screen.dart';
import 'pages/posts_list_screen.dart';

class PostRouter extends ModuleRouter {
  @override
  String get basePath => '/posts';

  @override
  List<RouteBase> get routes => [
    // List all posts
    GoRoute(
      path: basePath,
      name: 'post-list',
      builder: (context, state) => const PostsListScreen(),
    ),

    // View post details
    GoRoute(
      path: '$basePath/:postId',
      name: 'post-details',
      builder: (context, state) {
        final postId = state.pathParameters['postId']!;
        return PostDetailsScreen(postId: postId);
      },
    ),
  ];
}
