// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userModels.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserModels {

 String get uid; String get role;
/// Create a copy of UserModels
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelsCopyWith<UserModels> get copyWith => _$UserModelsCopyWithImpl<UserModels>(this as UserModels, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModels&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,uid,role);

@override
String toString() {
  return 'UserModels(uid: $uid, role: $role)';
}


}

/// @nodoc
abstract mixin class $UserModelsCopyWith<$Res>  {
  factory $UserModelsCopyWith(UserModels value, $Res Function(UserModels) _then) = _$UserModelsCopyWithImpl;
@useResult
$Res call({
 String uid, String role
});




}
/// @nodoc
class _$UserModelsCopyWithImpl<$Res>
    implements $UserModelsCopyWith<$Res> {
  _$UserModelsCopyWithImpl(this._self, this._then);

  final UserModels _self;
  final $Res Function(UserModels) _then;

/// Create a copy of UserModels
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? role = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModels].
extension UserModelsPatterns on UserModels {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModels value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModels() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModels value)  $default,){
final _that = this;
switch (_that) {
case _UserModels():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModels value)?  $default,){
final _that = this;
switch (_that) {
case _UserModels() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModels() when $default != null:
return $default(_that.uid,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String role)  $default,) {final _that = this;
switch (_that) {
case _UserModels():
return $default(_that.uid,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String role)?  $default,) {final _that = this;
switch (_that) {
case _UserModels() when $default != null:
return $default(_that.uid,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _UserModels extends UserModels {
  const _UserModels({required this.uid, required this.role}): super._();
  

@override final  String uid;
@override final  String role;

/// Create a copy of UserModels
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelsCopyWith<_UserModels> get copyWith => __$UserModelsCopyWithImpl<_UserModels>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModels&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,uid,role);

@override
String toString() {
  return 'UserModels(uid: $uid, role: $role)';
}


}

/// @nodoc
abstract mixin class _$UserModelsCopyWith<$Res> implements $UserModelsCopyWith<$Res> {
  factory _$UserModelsCopyWith(_UserModels value, $Res Function(_UserModels) _then) = __$UserModelsCopyWithImpl;
@override @useResult
$Res call({
 String uid, String role
});




}
/// @nodoc
class __$UserModelsCopyWithImpl<$Res>
    implements _$UserModelsCopyWith<$Res> {
  __$UserModelsCopyWithImpl(this._self, this._then);

  final _UserModels _self;
  final $Res Function(_UserModels) _then;

/// Create a copy of UserModels
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? role = null,}) {
  return _then(_UserModels(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
