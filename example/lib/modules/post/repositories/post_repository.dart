import '../models/post_model.dart';

/// Abstract repository interface for post operations
abstract class PostRepository {
  /// Fetch all posts
  Future<List<Post>> fetchPosts();

  /// Fetch a single post by ID
  Future<Post> fetchPost(int id);

  /// Create a new post
  Future<Post> createPost(Post post);

  /// Update an existing post
  Future<Post> updatePost(Post post);

  /// Delete a post by ID
  Future<void> deletePost(int id);
}
