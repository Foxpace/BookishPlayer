// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnostics_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagnosticsState {

 DiagnosticsStatus get status; DiagnosticsMessage? get message; int get effectRevision;
/// Create a copy of DiagnosticsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosticsStateCopyWith<DiagnosticsState> get copyWith => _$DiagnosticsStateCopyWithImpl<DiagnosticsState>(this as DiagnosticsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosticsState&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,message,effectRevision);

@override
String toString() {
  return 'DiagnosticsState(status: $status, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class $DiagnosticsStateCopyWith<$Res>  {
  factory $DiagnosticsStateCopyWith(DiagnosticsState value, $Res Function(DiagnosticsState) _then) = _$DiagnosticsStateCopyWithImpl;
@useResult
$Res call({
 DiagnosticsStatus status, DiagnosticsMessage? message, int effectRevision
});




}
/// @nodoc
class _$DiagnosticsStateCopyWithImpl<$Res>
    implements $DiagnosticsStateCopyWith<$Res> {
  _$DiagnosticsStateCopyWithImpl(this._self, this._then);

  final DiagnosticsState _self;
  final $Res Function(DiagnosticsState) _then;

/// Create a copy of DiagnosticsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DiagnosticsStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as DiagnosticsMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagnosticsState].
extension DiagnosticsStatePatterns on DiagnosticsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiagnosticsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagnosticsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiagnosticsState value)  $default,){
final _that = this;
switch (_that) {
case _DiagnosticsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiagnosticsState value)?  $default,){
final _that = this;
switch (_that) {
case _DiagnosticsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DiagnosticsStatus status,  DiagnosticsMessage? message,  int effectRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagnosticsState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DiagnosticsStatus status,  DiagnosticsMessage? message,  int effectRevision)  $default,) {final _that = this;
switch (_that) {
case _DiagnosticsState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DiagnosticsStatus status,  DiagnosticsMessage? message,  int effectRevision)?  $default,) {final _that = this;
switch (_that) {
case _DiagnosticsState() when $default != null:
return $default(_that.status,_that.message,_that.effectRevision);case _:
  return null;

}
}

}

/// @nodoc


class _DiagnosticsState implements DiagnosticsState {
  const _DiagnosticsState({this.status = DiagnosticsStatus.idle, this.message, this.effectRevision = 0});
  

@override@JsonKey() final  DiagnosticsStatus status;
@override final  DiagnosticsMessage? message;
@override@JsonKey() final  int effectRevision;

/// Create a copy of DiagnosticsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagnosticsStateCopyWith<_DiagnosticsState> get copyWith => __$DiagnosticsStateCopyWithImpl<_DiagnosticsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagnosticsState&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,message,effectRevision);

@override
String toString() {
  return 'DiagnosticsState(status: $status, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class _$DiagnosticsStateCopyWith<$Res> implements $DiagnosticsStateCopyWith<$Res> {
  factory _$DiagnosticsStateCopyWith(_DiagnosticsState value, $Res Function(_DiagnosticsState) _then) = __$DiagnosticsStateCopyWithImpl;
@override @useResult
$Res call({
 DiagnosticsStatus status, DiagnosticsMessage? message, int effectRevision
});




}
/// @nodoc
class __$DiagnosticsStateCopyWithImpl<$Res>
    implements _$DiagnosticsStateCopyWith<$Res> {
  __$DiagnosticsStateCopyWithImpl(this._self, this._then);

  final _DiagnosticsState _self;
  final $Res Function(_DiagnosticsState) _then;

/// Create a copy of DiagnosticsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_DiagnosticsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DiagnosticsStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as DiagnosticsMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
