import 'package:modular_flutter/modular_flutter.dart';
import 'package:viewmodel/viewmodel.dart';

import '../../repositories/post_repository.dart';
import 'post_details_state.dart';

/// ViewModel for the post details screen
class PostDetailsViewModel extends ViewModel<PostDetailsState> {
  final PostRepository _postRepository;
  final int postId;

  PostDetailsViewModel(this._postRepository, this.postId)
    : super(const PostDetailsState());

  @override
  Future<void> onInit() async {
    await loadPost();
  }

  /// Load a specific post by ID
  Future<void> loadPost() async {
    try {
      state = state.loading;
      final post = await _postRepository.fetchPost(postId);
      state = state.withPost(post);
    } catch (e) {
      state = state.error(e.toString());
    }
  }

  /// Refresh the post details
  Future<void> refreshPost() async {
    await loadPost();
  }

  /// Delete the current post
  Future<bool> deletePost() async {
    if (state.post == null) return false;

    try {
      state = state.deleting;
      await _postRepository.deletePost(state.post!.id);
      state = state.deleteSuccess;
      return true;
    } catch (e) {
      state = state.error('Failed to delete post: ${e.toString()}');
      return false;
    }
  }
}

final postDetailsViewModelProvider =
    StateNotifierProvider.family<PostDetailsViewModel, PostDetailsState, int>((
      ref,
      postId,
    ) {
      final repository = serviceLocator.get<PostRepository>();
      return PostDetailsViewModel(repository, postId);
    });
