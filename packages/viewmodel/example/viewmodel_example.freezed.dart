// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'viewmodel_example.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CounterUiState {

 int get value; UiStatus get uiStatus; String? get message; String? get errorMessage;
/// Create a copy of CounterUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CounterUiStateCopyWith<CounterUiState> get copyWith => _$CounterUiStateCopyWithImpl<CounterUiState>(this as CounterUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CounterUiState&&(identical(other.value, value) || other.value == value)&&(identical(other.uiStatus, uiStatus) || other.uiStatus == uiStatus)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,value,uiStatus,message,errorMessage);

@override
String toString() {
  return 'CounterUiState(value: $value, uiStatus: $uiStatus, message: $message, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CounterUiStateCopyWith<$Res>  {
  factory $CounterUiStateCopyWith(CounterUiState value, $Res Function(CounterUiState) _then) = _$CounterUiStateCopyWithImpl;
@useResult
$Res call({
 int value, UiStatus uiStatus, String? message, String? errorMessage
});




}
/// @nodoc
class _$CounterUiStateCopyWithImpl<$Res>
    implements $CounterUiStateCopyWith<$Res> {
  _$CounterUiStateCopyWithImpl(this._self, this._then);

  final CounterUiState _self;
  final $Res Function(CounterUiState) _then;

/// Create a copy of CounterUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? uiStatus = null,Object? message = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,uiStatus: null == uiStatus ? _self.uiStatus : uiStatus // ignore: cast_nullable_to_non_nullable
as UiStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CounterUiState].
extension CounterUiStatePatterns on CounterUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CounterUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CounterUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CounterUiState value)  $default,){
final _that = this;
switch (_that) {
case _CounterUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CounterUiState value)?  $default,){
final _that = this;
switch (_that) {
case _CounterUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int value,  UiStatus uiStatus,  String? message,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CounterUiState() when $default != null:
return $default(_that.value,_that.uiStatus,_that.message,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int value,  UiStatus uiStatus,  String? message,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CounterUiState():
return $default(_that.value,_that.uiStatus,_that.message,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int value,  UiStatus uiStatus,  String? message,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CounterUiState() when $default != null:
return $default(_that.value,_that.uiStatus,_that.message,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CounterUiState extends CounterUiState {
  const _CounterUiState({required this.value, this.uiStatus = UiStatus.initial, this.message, this.errorMessage}): super._();
  

@override final  int value;
@override@JsonKey() final  UiStatus uiStatus;
@override final  String? message;
@override final  String? errorMessage;

/// Create a copy of CounterUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CounterUiStateCopyWith<_CounterUiState> get copyWith => __$CounterUiStateCopyWithImpl<_CounterUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CounterUiState&&(identical(other.value, value) || other.value == value)&&(identical(other.uiStatus, uiStatus) || other.uiStatus == uiStatus)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,value,uiStatus,message,errorMessage);

@override
String toString() {
  return 'CounterUiState(value: $value, uiStatus: $uiStatus, message: $message, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CounterUiStateCopyWith<$Res> implements $CounterUiStateCopyWith<$Res> {
  factory _$CounterUiStateCopyWith(_CounterUiState value, $Res Function(_CounterUiState) _then) = __$CounterUiStateCopyWithImpl;
@override @useResult
$Res call({
 int value, UiStatus uiStatus, String? message, String? errorMessage
});




}
/// @nodoc
class __$CounterUiStateCopyWithImpl<$Res>
    implements _$CounterUiStateCopyWith<$Res> {
  __$CounterUiStateCopyWithImpl(this._self, this._then);

  final _CounterUiState _self;
  final $Res Function(_CounterUiState) _then;

/// Create a copy of CounterUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? uiStatus = null,Object? message = freezed,Object? errorMessage = freezed,}) {
  return _then(_CounterUiState(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,uiStatus: null == uiStatus ? _self.uiStatus : uiStatus // ignore: cast_nullable_to_non_nullable
as UiStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$UserProfileUiState {

 String? get userName; String? get email; List<String> get posts; bool get isRefreshing; UiStatus get uiStatus; String? get message; String? get errorMessage;
/// Create a copy of UserProfileUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileUiStateCopyWith<UserProfileUiState> get copyWith => _$UserProfileUiStateCopyWithImpl<UserProfileUiState>(this as UserProfileUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileUiState&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.uiStatus, uiStatus) || other.uiStatus == uiStatus)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,userName,email,const DeepCollectionEquality().hash(posts),isRefreshing,uiStatus,message,errorMessage);

@override
String toString() {
  return 'UserProfileUiState(userName: $userName, email: $email, posts: $posts, isRefreshing: $isRefreshing, uiStatus: $uiStatus, message: $message, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $UserProfileUiStateCopyWith<$Res>  {
  factory $UserProfileUiStateCopyWith(UserProfileUiState value, $Res Function(UserProfileUiState) _then) = _$UserProfileUiStateCopyWithImpl;
@useResult
$Res call({
 String? userName, String? email, List<String> posts, bool isRefreshing, UiStatus uiStatus, String? message, String? errorMessage
});




}
/// @nodoc
class _$UserProfileUiStateCopyWithImpl<$Res>
    implements $UserProfileUiStateCopyWith<$Res> {
  _$UserProfileUiStateCopyWithImpl(this._self, this._then);

  final UserProfileUiState _self;
  final $Res Function(UserProfileUiState) _then;

/// Create a copy of UserProfileUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userName = freezed,Object? email = freezed,Object? posts = null,Object? isRefreshing = null,Object? uiStatus = null,Object? message = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<String>,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,uiStatus: null == uiStatus ? _self.uiStatus : uiStatus // ignore: cast_nullable_to_non_nullable
as UiStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileUiState].
extension UserProfileUiStatePatterns on UserProfileUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileUiState value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileUiState value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? userName,  String? email,  List<String> posts,  bool isRefreshing,  UiStatus uiStatus,  String? message,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileUiState() when $default != null:
return $default(_that.userName,_that.email,_that.posts,_that.isRefreshing,_that.uiStatus,_that.message,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? userName,  String? email,  List<String> posts,  bool isRefreshing,  UiStatus uiStatus,  String? message,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _UserProfileUiState():
return $default(_that.userName,_that.email,_that.posts,_that.isRefreshing,_that.uiStatus,_that.message,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? userName,  String? email,  List<String> posts,  bool isRefreshing,  UiStatus uiStatus,  String? message,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileUiState() when $default != null:
return $default(_that.userName,_that.email,_that.posts,_that.isRefreshing,_that.uiStatus,_that.message,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfileUiState extends UserProfileUiState {
  const _UserProfileUiState({this.userName, this.email, final  List<String> posts = const [], this.isRefreshing = false, this.uiStatus = UiStatus.initial, this.message, this.errorMessage}): _posts = posts,super._();
  

@override final  String? userName;
@override final  String? email;
 final  List<String> _posts;
@override@JsonKey() List<String> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  UiStatus uiStatus;
@override final  String? message;
@override final  String? errorMessage;

/// Create a copy of UserProfileUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileUiStateCopyWith<_UserProfileUiState> get copyWith => __$UserProfileUiStateCopyWithImpl<_UserProfileUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileUiState&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.uiStatus, uiStatus) || other.uiStatus == uiStatus)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,userName,email,const DeepCollectionEquality().hash(_posts),isRefreshing,uiStatus,message,errorMessage);

@override
String toString() {
  return 'UserProfileUiState(userName: $userName, email: $email, posts: $posts, isRefreshing: $isRefreshing, uiStatus: $uiStatus, message: $message, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$UserProfileUiStateCopyWith<$Res> implements $UserProfileUiStateCopyWith<$Res> {
  factory _$UserProfileUiStateCopyWith(_UserProfileUiState value, $Res Function(_UserProfileUiState) _then) = __$UserProfileUiStateCopyWithImpl;
@override @useResult
$Res call({
 String? userName, String? email, List<String> posts, bool isRefreshing, UiStatus uiStatus, String? message, String? errorMessage
});




}
/// @nodoc
class __$UserProfileUiStateCopyWithImpl<$Res>
    implements _$UserProfileUiStateCopyWith<$Res> {
  __$UserProfileUiStateCopyWithImpl(this._self, this._then);

  final _UserProfileUiState _self;
  final $Res Function(_UserProfileUiState) _then;

/// Create a copy of UserProfileUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userName = freezed,Object? email = freezed,Object? posts = null,Object? isRefreshing = null,Object? uiStatus = null,Object? message = freezed,Object? errorMessage = freezed,}) {
  return _then(_UserProfileUiState(
userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<String>,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,uiStatus: null == uiStatus ? _self.uiStatus : uiStatus // ignore: cast_nullable_to_non_nullable
as UiStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
