import 'package:viewmodel/viewmodel.dart';
import '../models/post_model.dart';

part 'posts_list_state.freezed.dart';

@freezed
abstract class PostsListState extends UiState<PostsListState>
    with _$PostsListState {
  const PostsListState._();

  const factory PostsListState({
    @Default([]) List<Post> posts,
    @Default(Status.initial) Status status,
    @Default('') String errorMessage,
  }) = _PostsListState;

  @override
  PostsListState get loading => copyWith(status: Status.loading);

  PostsListState get success => copyWith(status: Status.success);

  PostsListState error(String message) =>
      copyWith(status: Status.error, errorMessage: message);

  PostsListState withPosts(List<Post> posts) =>
      copyWith(posts: posts, status: Status.success, errorMessage: '');
}
