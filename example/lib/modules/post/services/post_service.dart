import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client _client;

  PostService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetch all posts
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/posts'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load posts: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  /// Fetch a single post by ID
  Future<Post> fetchPost(int id) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/posts/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Post.fromJson(jsonData);
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching post: $e');
    }
  }

  /// Create a new post
  Future<Post> createPost(Post post) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/posts'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(post.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Post.fromJson(jsonData);
      } else {
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }

  /// Update an existing post
  Future<Post> updatePost(Post post) async {
    try {
      final response = await _client.put(
        Uri.parse('$_baseUrl/posts/${post.id}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(post.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Post.fromJson(jsonData);
      } else {
        throw Exception('Failed to update post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating post: $e');
    }
  }

  /// Delete a post
  Future<void> deletePost(int id) async {
    try {
      final response = await _client.delete(
        Uri.parse('$_baseUrl/posts/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting post: $e');
    }
  }

  /// Dispose the HTTP client
  void dispose() {
    _client.close();
  }
}
