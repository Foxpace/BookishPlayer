// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portability_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PortabilityState {

 PortabilityStatus get status; PortabilityMessage? get message; int get effectRevision;
/// Create a copy of PortabilityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortabilityStateCopyWith<PortabilityState> get copyWith => _$PortabilityStateCopyWithImpl<PortabilityState>(this as PortabilityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortabilityState&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,message,effectRevision);

@override
String toString() {
  return 'PortabilityState(status: $status, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class $PortabilityStateCopyWith<$Res>  {
  factory $PortabilityStateCopyWith(PortabilityState value, $Res Function(PortabilityState) _then) = _$PortabilityStateCopyWithImpl;
@useResult
$Res call({
 PortabilityStatus status, PortabilityMessage? message, int effectRevision
});




}
/// @nodoc
class _$PortabilityStateCopyWithImpl<$Res>
    implements $PortabilityStateCopyWith<$Res> {
  _$PortabilityStateCopyWithImpl(this._self, this._then);

  final PortabilityState _self;
  final $Res Function(PortabilityState) _then;

/// Create a copy of PortabilityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PortabilityStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as PortabilityMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PortabilityState].
extension PortabilityStatePatterns on PortabilityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortabilityState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortabilityState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortabilityState value)  $default,){
final _that = this;
switch (_that) {
case _PortabilityState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortabilityState value)?  $default,){
final _that = this;
switch (_that) {
case _PortabilityState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PortabilityStatus status,  PortabilityMessage? message,  int effectRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortabilityState() when $default != null:
return $default(_that.status,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PortabilityStatus status,  PortabilityMessage? message,  int effectRevision)  $default,) {final _that = this;
switch (_that) {
case _PortabilityState():
return $default(_that.status,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PortabilityStatus status,  PortabilityMessage? message,  int effectRevision)?  $default,) {final _that = this;
switch (_that) {
case _PortabilityState() when $default != null:
return $default(_that.status,_that.message,_that.effectRevision);case _:
  return null;

}
}

}

/// @nodoc


class _PortabilityState implements PortabilityState {
  const _PortabilityState({this.status = PortabilityStatus.idle, this.message, this.effectRevision = 0});
  

@override@JsonKey() final  PortabilityStatus status;
@override final  PortabilityMessage? message;
@override@JsonKey() final  int effectRevision;

/// Create a copy of PortabilityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortabilityStateCopyWith<_PortabilityState> get copyWith => __$PortabilityStateCopyWithImpl<_PortabilityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortabilityState&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,message,effectRevision);

@override
String toString() {
  return 'PortabilityState(status: $status, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class _$PortabilityStateCopyWith<$Res> implements $PortabilityStateCopyWith<$Res> {
  factory _$PortabilityStateCopyWith(_PortabilityState value, $Res Function(_PortabilityState) _then) = __$PortabilityStateCopyWithImpl;
@override @useResult
$Res call({
 PortabilityStatus status, PortabilityMessage? message, int effectRevision
});




}
/// @nodoc
class __$PortabilityStateCopyWithImpl<$Res>
    implements _$PortabilityStateCopyWith<$Res> {
  __$PortabilityStateCopyWithImpl(this._self, this._then);

  final _PortabilityState _self;
  final $Res Function(_PortabilityState) _then;

/// Create a copy of PortabilityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_PortabilityState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PortabilityStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as PortabilityMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
