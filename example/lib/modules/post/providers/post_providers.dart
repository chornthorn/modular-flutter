import 'package:viewmodel/viewmodel.dart';
import 'package:modular_flutter/modular_flutter.dart';
import '../repositories/post_repository.dart';
import '../viewmodels/posts_list_viewmodel.dart';
import '../viewmodels/post_details_viewmodel.dart';
import '../states/posts_list_state.dart';
import '../states/post_details_state.dart';

/// Provider for PostRepository
final _postRepositoryProvider = Provider<PostRepository>((ref) {
  return Modular.get<PostRepository>();
});

/// Provider for PostsListViewModel
final postsListViewModelProvider =
    StateNotifierProvider<PostsListViewModel, PostsListState>((ref) {
      final repository = ref.watch(_postRepositoryProvider);
      return PostsListViewModel(repository);
    });

/// Provider for PostDetailsViewModel
/// This is a family provider that takes a postId parameter
final postDetailsViewModelProvider =
    StateNotifierProvider.family<PostDetailsViewModel, PostDetailsState, int>((
      ref,
      postId,
    ) {
      final repository = ref.watch(_postRepositoryProvider);
      return PostDetailsViewModel(repository, postId);
    });
