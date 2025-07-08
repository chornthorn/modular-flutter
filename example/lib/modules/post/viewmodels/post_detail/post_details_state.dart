import 'package:viewmodel/viewmodel.dart';

import '../../models/post_model.dart';

part 'post_details_state.freezed.dart';

@freezed
abstract class PostDetailsState extends UiState<PostDetailsState>
    with _$PostDetailsState {
  const PostDetailsState._();

  const factory PostDetailsState({
    Post? post,
    @Default(UiStatus.initial) UiStatus uiStatus,
    @Default('') String errorMessage,
    @Default(false) bool isDeleting,
  }) = _PostDetailsState;

  @override
  PostDetailsState get loading => copyWith(uiStatus: UiStatus.loading);

  PostDetailsState get success => copyWith(uiStatus: UiStatus.success);

  PostDetailsState get deleting => copyWith(isDeleting: true);

  PostDetailsState error(String message) => copyWith(
    uiStatus: UiStatus.error,
    errorMessage: message,
    isDeleting: false,
  );

  PostDetailsState withPost(Post post) => copyWith(
    post: post,
    uiStatus: UiStatus.success,
    errorMessage: '',
    isDeleting: false,
  );

  PostDetailsState get deleteSuccess =>
      copyWith(uiStatus: UiStatus.success, isDeleting: false);
}
