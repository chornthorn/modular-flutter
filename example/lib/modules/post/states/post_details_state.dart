import 'package:viewmodel/viewmodel.dart';
import '../models/post_model.dart';

part 'post_details_state.freezed.dart';

@freezed
abstract class PostDetailsState extends UiState<PostDetailsState>
    with _$PostDetailsState {
  const PostDetailsState._();

  const factory PostDetailsState({
    Post? post,
    @Default(Status.initial) Status status,
    @Default('') String errorMessage,
    @Default(false) bool isDeleting,
  }) = _PostDetailsState;

  @override
  PostDetailsState get loading => copyWith(status: Status.loading);

  PostDetailsState get success => copyWith(status: Status.success);

  PostDetailsState get deleting => copyWith(isDeleting: true);

  PostDetailsState error(String message) =>
      copyWith(status: Status.error, errorMessage: message, isDeleting: false);

  PostDetailsState withPost(Post post) => copyWith(
    post: post,
    status: Status.success,
    errorMessage: '',
    isDeleting: false,
  );

  PostDetailsState get deleteSuccess =>
      copyWith(status: Status.success, isDeleting: false);
}
