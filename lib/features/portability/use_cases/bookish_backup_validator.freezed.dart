// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookish_backup_validator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackupValidationException {

 BackupValidationFailure get failure; String? get recordId;
/// Create a copy of BackupValidationException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupValidationExceptionCopyWith<BackupValidationException> get copyWith => _$BackupValidationExceptionCopyWithImpl<BackupValidationException>(this as BackupValidationException, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupValidationException&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.recordId, recordId) || other.recordId == recordId));
}


@override
int get hashCode => Object.hash(runtimeType,failure,recordId);

@override
String toString() {
  return 'BackupValidationException(failure: $failure, recordId: $recordId)';
}


}

/// @nodoc
abstract mixin class $BackupValidationExceptionCopyWith<$Res>  {
  factory $BackupValidationExceptionCopyWith(BackupValidationException value, $Res Function(BackupValidationException) _then) = _$BackupValidationExceptionCopyWithImpl;
@useResult
$Res call({
 BackupValidationFailure failure, String? recordId
});




}
/// @nodoc
class _$BackupValidationExceptionCopyWithImpl<$Res>
    implements $BackupValidationExceptionCopyWith<$Res> {
  _$BackupValidationExceptionCopyWithImpl(this._self, this._then);

  final BackupValidationException _self;
  final $Res Function(BackupValidationException) _then;

/// Create a copy of BackupValidationException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? failure = null,Object? recordId = freezed,}) {
  return _then(_self.copyWith(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as BackupValidationFailure,recordId: freezed == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupValidationException].
extension BackupValidationExceptionPatterns on BackupValidationException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupValidationException value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupValidationException() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupValidationException value)  $default,){
final _that = this;
switch (_that) {
case _BackupValidationException():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupValidationException value)?  $default,){
final _that = this;
switch (_that) {
case _BackupValidationException() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BackupValidationFailure failure,  String? recordId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupValidationException() when $default != null:
return $default(_that.failure,_that.recordId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BackupValidationFailure failure,  String? recordId)  $default,) {final _that = this;
switch (_that) {
case _BackupValidationException():
return $default(_that.failure,_that.recordId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BackupValidationFailure failure,  String? recordId)?  $default,) {final _that = this;
switch (_that) {
case _BackupValidationException() when $default != null:
return $default(_that.failure,_that.recordId);case _:
  return null;

}
}

}

/// @nodoc


class _BackupValidationException implements BackupValidationException {
  const _BackupValidationException(this.failure, {this.recordId});
  

@override final  BackupValidationFailure failure;
@override final  String? recordId;

/// Create a copy of BackupValidationException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupValidationExceptionCopyWith<_BackupValidationException> get copyWith => __$BackupValidationExceptionCopyWithImpl<_BackupValidationException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupValidationException&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.recordId, recordId) || other.recordId == recordId));
}


@override
int get hashCode => Object.hash(runtimeType,failure,recordId);

@override
String toString() {
  return 'BackupValidationException(failure: $failure, recordId: $recordId)';
}


}

/// @nodoc
abstract mixin class _$BackupValidationExceptionCopyWith<$Res> implements $BackupValidationExceptionCopyWith<$Res> {
  factory _$BackupValidationExceptionCopyWith(_BackupValidationException value, $Res Function(_BackupValidationException) _then) = __$BackupValidationExceptionCopyWithImpl;
@override @useResult
$Res call({
 BackupValidationFailure failure, String? recordId
});




}
/// @nodoc
class __$BackupValidationExceptionCopyWithImpl<$Res>
    implements _$BackupValidationExceptionCopyWith<$Res> {
  __$BackupValidationExceptionCopyWithImpl(this._self, this._then);

  final _BackupValidationException _self;
  final $Res Function(_BackupValidationException) _then;

/// Create a copy of BackupValidationException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? recordId = freezed,}) {
  return _then(_BackupValidationException(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as BackupValidationFailure,recordId: freezed == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
