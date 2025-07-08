// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posts_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostsListState {

 List<Post> get posts; Status get status; String get errorMessage;
/// Create a copy of PostsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostsListStateCopyWith<PostsListState> get copyWith => _$PostsListStateCopyWithImpl<PostsListState>(this as PostsListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostsListState&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(posts),status,errorMessage);

@override
String toString() {
  return 'PostsListState(posts: $posts, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PostsListStateCopyWith<$Res>  {
  factory $PostsListStateCopyWith(PostsListState value, $Res Function(PostsListState) _then) = _$PostsListStateCopyWithImpl;
@useResult
$Res call({
 List<Post> posts, Status status, String errorMessage
});




}
/// @nodoc
class _$PostsListStateCopyWithImpl<$Res>
    implements $PostsListStateCopyWith<$Res> {
  _$PostsListStateCopyWithImpl(this._self, this._then);

  final PostsListState _self;
  final $Res Function(PostsListState) _then;

/// Create a copy of PostsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? posts = null,Object? status = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PostsListState].
extension PostsListStatePatterns on PostsListState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostsListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostsListState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostsListState value)  $default,){
final _that = this;
switch (_that) {
case _PostsListState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostsListState value)?  $default,){
final _that = this;
switch (_that) {
case _PostsListState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Post> posts,  Status status,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostsListState() when $default != null:
return $default(_that.posts,_that.status,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Post> posts,  Status status,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PostsListState():
return $default(_that.posts,_that.status,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Post> posts,  Status status,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PostsListState() when $default != null:
return $default(_that.posts,_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PostsListState extends PostsListState {
  const _PostsListState({final  List<Post> posts = const [], this.status = Status.initial, this.errorMessage = ''}): _posts = posts,super._();
  

 final  List<Post> _posts;
@override@JsonKey() List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override@JsonKey() final  Status status;
@override@JsonKey() final  String errorMessage;

/// Create a copy of PostsListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostsListStateCopyWith<_PostsListState> get copyWith => __$PostsListStateCopyWithImpl<_PostsListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostsListState&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts),status,errorMessage);

@override
String toString() {
  return 'PostsListState(posts: $posts, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PostsListStateCopyWith<$Res> implements $PostsListStateCopyWith<$Res> {
  factory _$PostsListStateCopyWith(_PostsListState value, $Res Function(_PostsListState) _then) = __$PostsListStateCopyWithImpl;
@override @useResult
$Res call({
 List<Post> posts, Status status, String errorMessage
});




}
/// @nodoc
class __$PostsListStateCopyWithImpl<$Res>
    implements _$PostsListStateCopyWith<$Res> {
  __$PostsListStateCopyWithImpl(this._self, this._then);

  final _PostsListState _self;
  final $Res Function(_PostsListState) _then;

/// Create a copy of PostsListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? posts = null,Object? status = null,Object? errorMessage = null,}) {
  return _then(_PostsListState(
posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
