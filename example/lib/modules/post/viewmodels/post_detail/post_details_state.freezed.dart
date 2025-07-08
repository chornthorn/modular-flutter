// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostDetailsState {

 Post? get post; UiStatus get uiStatus; String get errorMessage; bool get isDeleting;
/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDetailsStateCopyWith<PostDetailsState> get copyWith => _$PostDetailsStateCopyWithImpl<PostDetailsState>(this as PostDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDetailsState&&(identical(other.post, post) || other.post == post)&&(identical(other.uiStatus, uiStatus) || other.uiStatus == uiStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting));
}


@override
int get hashCode => Object.hash(runtimeType,post,uiStatus,errorMessage,isDeleting);

@override
String toString() {
  return 'PostDetailsState(post: $post, uiStatus: $uiStatus, errorMessage: $errorMessage, isDeleting: $isDeleting)';
}


}

/// @nodoc
abstract mixin class $PostDetailsStateCopyWith<$Res>  {
  factory $PostDetailsStateCopyWith(PostDetailsState value, $Res Function(PostDetailsState) _then) = _$PostDetailsStateCopyWithImpl;
@useResult
$Res call({
 Post? post, UiStatus uiStatus, String errorMessage, bool isDeleting
});




}
/// @nodoc
class _$PostDetailsStateCopyWithImpl<$Res>
    implements $PostDetailsStateCopyWith<$Res> {
  _$PostDetailsStateCopyWithImpl(this._self, this._then);

  final PostDetailsState _self;
  final $Res Function(PostDetailsState) _then;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? post = freezed,Object? uiStatus = null,Object? errorMessage = null,Object? isDeleting = null,}) {
  return _then(_self.copyWith(
post: freezed == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post?,uiStatus: null == uiStatus ? _self.uiStatus : uiStatus // ignore: cast_nullable_to_non_nullable
as UiStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostDetailsState].
extension PostDetailsStatePatterns on PostDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _PostDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _PostDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Post? post,  UiStatus uiStatus,  String errorMessage,  bool isDeleting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDetailsState() when $default != null:
return $default(_that.post,_that.uiStatus,_that.errorMessage,_that.isDeleting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Post? post,  UiStatus uiStatus,  String errorMessage,  bool isDeleting)  $default,) {final _that = this;
switch (_that) {
case _PostDetailsState():
return $default(_that.post,_that.uiStatus,_that.errorMessage,_that.isDeleting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Post? post,  UiStatus uiStatus,  String errorMessage,  bool isDeleting)?  $default,) {final _that = this;
switch (_that) {
case _PostDetailsState() when $default != null:
return $default(_that.post,_that.uiStatus,_that.errorMessage,_that.isDeleting);case _:
  return null;

}
}

}

/// @nodoc


class _PostDetailsState extends PostDetailsState {
  const _PostDetailsState({this.post, this.uiStatus = UiStatus.initial, this.errorMessage = '', this.isDeleting = false}): super._();
  

@override final  Post? post;
@override@JsonKey() final  UiStatus uiStatus;
@override@JsonKey() final  String errorMessage;
@override@JsonKey() final  bool isDeleting;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDetailsStateCopyWith<_PostDetailsState> get copyWith => __$PostDetailsStateCopyWithImpl<_PostDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDetailsState&&(identical(other.post, post) || other.post == post)&&(identical(other.uiStatus, uiStatus) || other.uiStatus == uiStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting));
}


@override
int get hashCode => Object.hash(runtimeType,post,uiStatus,errorMessage,isDeleting);

@override
String toString() {
  return 'PostDetailsState(post: $post, uiStatus: $uiStatus, errorMessage: $errorMessage, isDeleting: $isDeleting)';
}


}

/// @nodoc
abstract mixin class _$PostDetailsStateCopyWith<$Res> implements $PostDetailsStateCopyWith<$Res> {
  factory _$PostDetailsStateCopyWith(_PostDetailsState value, $Res Function(_PostDetailsState) _then) = __$PostDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 Post? post, UiStatus uiStatus, String errorMessage, bool isDeleting
});




}
/// @nodoc
class __$PostDetailsStateCopyWithImpl<$Res>
    implements _$PostDetailsStateCopyWith<$Res> {
  __$PostDetailsStateCopyWithImpl(this._self, this._then);

  final _PostDetailsState _self;
  final $Res Function(_PostDetailsState) _then;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? post = freezed,Object? uiStatus = null,Object? errorMessage = null,Object? isDeleting = null,}) {
  return _then(_PostDetailsState(
post: freezed == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post?,uiStatus: null == uiStatus ? _self.uiStatus : uiStatus // ignore: cast_nullable_to_non_nullable
as UiStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
