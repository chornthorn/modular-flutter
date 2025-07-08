import 'package:viewmodel/viewmodel.dart';
import '../repositories/post_repository.dart';
import '../states/posts_list_state.dart';

/// ViewModel for the posts list screen
class PostsListViewModel extends ViewModel<PostsListState> {
  final PostRepository _postRepository;

  PostsListViewModel(this._postRepository) : super(const PostsListState());

  @override
  Future<void> onInit() async {
    await loadPosts();
  }

  /// Load all posts from the repository
  Future<void> loadPosts() async {
    try {
      state = state.loading;
      final posts = await _postRepository.fetchPosts();
      state = state.withPosts(posts);
    } catch (e) {
      state = state.error(e.toString());
    }
  }

  /// Refresh the posts list
  Future<void> refreshPosts() async {
    await loadPosts();
  }

  /// Delete a post and refresh the list
  Future<bool> deletePost(int postId) async {
    try {
      await _postRepository.deletePost(postId);
      // Refresh the list after deletion
      await loadPosts();
      return true;
    } catch (e) {
      state = state.error('Failed to delete post: ${e.toString()}');
      return false;
    }
  }
}
