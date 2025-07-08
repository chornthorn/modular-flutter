// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'viewmodel_example.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CounterUiState {
  int get value => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CounterUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CounterUiStateCopyWith<CounterUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterUiStateCopyWith<$Res> {
  factory $CounterUiStateCopyWith(
    CounterUiState value,
    $Res Function(CounterUiState) then,
  ) = _$CounterUiStateCopyWithImpl<$Res, CounterUiState>;
  @useResult
  $Res call({int value, Status status, String? message, String? errorMessage});
}

/// @nodoc
class _$CounterUiStateCopyWithImpl<$Res, $Val extends CounterUiState>
    implements $CounterUiStateCopyWith<$Res> {
  _$CounterUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CounterUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? status = null,
    Object? message = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            value:
                null == value
                    ? _value.value
                    : value // ignore: cast_nullable_to_non_nullable
                        as int,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as Status,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CounterUiStateImplCopyWith<$Res>
    implements $CounterUiStateCopyWith<$Res> {
  factory _$$CounterUiStateImplCopyWith(
    _$CounterUiStateImpl value,
    $Res Function(_$CounterUiStateImpl) then,
  ) = __$$CounterUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, Status status, String? message, String? errorMessage});
}

/// @nodoc
class __$$CounterUiStateImplCopyWithImpl<$Res>
    extends _$CounterUiStateCopyWithImpl<$Res, _$CounterUiStateImpl>
    implements _$$CounterUiStateImplCopyWith<$Res> {
  __$$CounterUiStateImplCopyWithImpl(
    _$CounterUiStateImpl _value,
    $Res Function(_$CounterUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CounterUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? status = null,
    Object? message = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CounterUiStateImpl(
        value:
            null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                    as int,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as Status,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$CounterUiStateImpl extends _CounterUiState {
  const _$CounterUiStateImpl({
    required this.value,
    this.status = Status.initial,
    this.message,
    this.errorMessage,
  }) : super._();

  @override
  final int value;
  @override
  @JsonKey()
  final Status status;
  @override
  final String? message;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CounterUiState(value: $value, status: $status, message: $message, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CounterUiStateImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, value, status, message, errorMessage);

  /// Create a copy of CounterUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CounterUiStateImplCopyWith<_$CounterUiStateImpl> get copyWith =>
      __$$CounterUiStateImplCopyWithImpl<_$CounterUiStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CounterUiState extends CounterUiState {
  const factory _CounterUiState({
    required final int value,
    final Status status,
    final String? message,
    final String? errorMessage,
  }) = _$CounterUiStateImpl;
  const _CounterUiState._() : super._();

  @override
  int get value;
  @override
  Status get status;
  @override
  String? get message;
  @override
  String? get errorMessage;

  /// Create a copy of CounterUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CounterUiStateImplCopyWith<_$CounterUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserProfileUiState {
  String? get userName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  List<String> get posts => throw _privateConstructorUsedError;
  bool get isRefreshing => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileUiStateCopyWith<UserProfileUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileUiStateCopyWith<$Res> {
  factory $UserProfileUiStateCopyWith(
    UserProfileUiState value,
    $Res Function(UserProfileUiState) then,
  ) = _$UserProfileUiStateCopyWithImpl<$Res, UserProfileUiState>;
  @useResult
  $Res call({
    String? userName,
    String? email,
    List<String> posts,
    bool isRefreshing,
    Status status,
    String? message,
    String? errorMessage,
  });
}

/// @nodoc
class _$UserProfileUiStateCopyWithImpl<$Res, $Val extends UserProfileUiState>
    implements $UserProfileUiStateCopyWith<$Res> {
  _$UserProfileUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = freezed,
    Object? email = freezed,
    Object? posts = null,
    Object? isRefreshing = null,
    Object? status = null,
    Object? message = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            userName:
                freezed == userName
                    ? _value.userName
                    : userName // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            posts:
                null == posts
                    ? _value.posts
                    : posts // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            isRefreshing:
                null == isRefreshing
                    ? _value.isRefreshing
                    : isRefreshing // ignore: cast_nullable_to_non_nullable
                        as bool,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as Status,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileUiStateImplCopyWith<$Res>
    implements $UserProfileUiStateCopyWith<$Res> {
  factory _$$UserProfileUiStateImplCopyWith(
    _$UserProfileUiStateImpl value,
    $Res Function(_$UserProfileUiStateImpl) then,
  ) = __$$UserProfileUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? userName,
    String? email,
    List<String> posts,
    bool isRefreshing,
    Status status,
    String? message,
    String? errorMessage,
  });
}

/// @nodoc
class __$$UserProfileUiStateImplCopyWithImpl<$Res>
    extends _$UserProfileUiStateCopyWithImpl<$Res, _$UserProfileUiStateImpl>
    implements _$$UserProfileUiStateImplCopyWith<$Res> {
  __$$UserProfileUiStateImplCopyWithImpl(
    _$UserProfileUiStateImpl _value,
    $Res Function(_$UserProfileUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = freezed,
    Object? email = freezed,
    Object? posts = null,
    Object? isRefreshing = null,
    Object? status = null,
    Object? message = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$UserProfileUiStateImpl(
        userName:
            freezed == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        posts:
            null == posts
                ? _value._posts
                : posts // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        isRefreshing:
            null == isRefreshing
                ? _value.isRefreshing
                : isRefreshing // ignore: cast_nullable_to_non_nullable
                    as bool,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as Status,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$UserProfileUiStateImpl extends _UserProfileUiState {
  const _$UserProfileUiStateImpl({
    this.userName,
    this.email,
    final List<String> posts = const [],
    this.isRefreshing = false,
    this.status = Status.initial,
    this.message,
    this.errorMessage,
  }) : _posts = posts,
       super._();

  @override
  final String? userName;
  @override
  final String? email;
  final List<String> _posts;
  @override
  @JsonKey()
  List<String> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  @JsonKey()
  final bool isRefreshing;
  @override
  @JsonKey()
  final Status status;
  @override
  final String? message;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'UserProfileUiState(userName: $userName, email: $email, posts: $posts, isRefreshing: $isRefreshing, status: $status, message: $message, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileUiStateImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userName,
    email,
    const DeepCollectionEquality().hash(_posts),
    isRefreshing,
    status,
    message,
    errorMessage,
  );

  /// Create a copy of UserProfileUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileUiStateImplCopyWith<_$UserProfileUiStateImpl> get copyWith =>
      __$$UserProfileUiStateImplCopyWithImpl<_$UserProfileUiStateImpl>(
        this,
        _$identity,
      );
}

abstract class _UserProfileUiState extends UserProfileUiState {
  const factory _UserProfileUiState({
    final String? userName,
    final String? email,
    final List<String> posts,
    final bool isRefreshing,
    final Status status,
    final String? message,
    final String? errorMessage,
  }) = _$UserProfileUiStateImpl;
  const _UserProfileUiState._() : super._();

  @override
  String? get userName;
  @override
  String? get email;
  @override
  List<String> get posts;
  @override
  bool get isRefreshing;
  @override
  Status get status;
  @override
  String? get message;
  @override
  String? get errorMessage;

  /// Create a copy of UserProfileUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileUiStateImplCopyWith<_$UserProfileUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
