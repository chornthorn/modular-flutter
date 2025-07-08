import 'package:viewmodel/viewmodel.dart';

import '../../models/post_model.dart';

part 'posts_list_state.freezed.dart';

@freezed
abstract class PostsListState extends UiState<PostsListState>
    with _$PostsListState {
  const PostsListState._();

  const factory PostsListState({
    @Default([]) List<Post> posts,
    @Default(UiStatus.initial) UiStatus uiStatus,
    @Default('') String errorMessage,
  }) = _PostsListState;

  @override
  PostsListState get loading => copyWith(uiStatus: UiStatus.loading);

  PostsListState get success => copyWith(uiStatus: UiStatus.success);

  PostsListState error(String message) =>
      copyWith(uiStatus: UiStatus.error, errorMessage: message);

  PostsListState withPosts(List<Post> posts) =>
      copyWith(posts: posts, uiStatus: UiStatus.success, errorMessage: '');
}
