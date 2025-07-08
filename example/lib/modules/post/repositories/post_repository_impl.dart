import '../models/post_model.dart';
import '../services/post_service.dart';
import 'post_repository.dart';

/// Implementation of PostRepository using PostService
class PostRepositoryImpl implements PostRepository {
  final PostService _postService;

  PostRepositoryImpl(this._postService);

  @override
  Future<List<Post>> fetchPosts() async {
    return await _postService.fetchPosts();
  }

  @override
  Future<Post> fetchPost(int id) async {
    return await _postService.fetchPost(id);
  }

  @override
  Future<Post> createPost(Post post) async {
    return await _postService.createPost(post);
  }

  @override
  Future<Post> updatePost(Post post) async {
    return await _postService.updatePost(post);
  }

  @override
  Future<void> deletePost(int id) async {
    return await _postService.deletePost(id);
  }
}
