// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppFailure {

 String get detail; Object? get error;
/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppFailureCopyWith<AppFailure> get copyWith => _$AppFailureCopyWithImpl<AppFailure>(this as AppFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppFailure&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,detail,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'AppFailure(detail: $detail, error: $error)';
}


}

/// @nodoc
abstract mixin class $AppFailureCopyWith<$Res>  {
  factory $AppFailureCopyWith(AppFailure value, $Res Function(AppFailure) _then) = _$AppFailureCopyWithImpl;
@useResult
$Res call({
 String detail, Object? error
});




}
/// @nodoc
class _$AppFailureCopyWithImpl<$Res>
    implements $AppFailureCopyWith<$Res> {
  _$AppFailureCopyWithImpl(this._self, this._then);

  final AppFailure _self;
  final $Res Function(AppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? detail = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,
  ));
}

}


/// Adds pattern-matching-related methods to [AppFailure].
extension AppFailurePatterns on AppFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CancelledFailure value)?  cancelled,TResult Function( NotFoundFailure value)?  notFound,TResult Function( InvalidDataFailure value)?  invalidData,TResult Function( OperationFailure value)?  operationFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CancelledFailure() when cancelled != null:
return cancelled(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case InvalidDataFailure() when invalidData != null:
return invalidData(_that);case OperationFailure() when operationFailed != null:
return operationFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CancelledFailure value)  cancelled,required TResult Function( NotFoundFailure value)  notFound,required TResult Function( InvalidDataFailure value)  invalidData,required TResult Function( OperationFailure value)  operationFailed,}){
final _that = this;
switch (_that) {
case CancelledFailure():
return cancelled(_that);case NotFoundFailure():
return notFound(_that);case InvalidDataFailure():
return invalidData(_that);case OperationFailure():
return operationFailed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CancelledFailure value)?  cancelled,TResult? Function( NotFoundFailure value)?  notFound,TResult? Function( InvalidDataFailure value)?  invalidData,TResult? Function( OperationFailure value)?  operationFailed,}){
final _that = this;
switch (_that) {
case CancelledFailure() when cancelled != null:
return cancelled(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case InvalidDataFailure() when invalidData != null:
return invalidData(_that);case OperationFailure() when operationFailed != null:
return operationFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String detail,  Object? error)?  cancelled,TResult Function( String detail,  Object? error)?  notFound,TResult Function( String detail,  Object? error)?  invalidData,TResult Function( String detail,  Object? error)?  operationFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CancelledFailure() when cancelled != null:
return cancelled(_that.detail,_that.error);case NotFoundFailure() when notFound != null:
return notFound(_that.detail,_that.error);case InvalidDataFailure() when invalidData != null:
return invalidData(_that.detail,_that.error);case OperationFailure() when operationFailed != null:
return operationFailed(_that.detail,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String detail,  Object? error)  cancelled,required TResult Function( String detail,  Object? error)  notFound,required TResult Function( String detail,  Object? error)  invalidData,required TResult Function( String detail,  Object? error)  operationFailed,}) {final _that = this;
switch (_that) {
case CancelledFailure():
return cancelled(_that.detail,_that.error);case NotFoundFailure():
return notFound(_that.detail,_that.error);case InvalidDataFailure():
return invalidData(_that.detail,_that.error);case OperationFailure():
return operationFailed(_that.detail,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String detail,  Object? error)?  cancelled,TResult? Function( String detail,  Object? error)?  notFound,TResult? Function( String detail,  Object? error)?  invalidData,TResult? Function( String detail,  Object? error)?  operationFailed,}) {final _that = this;
switch (_that) {
case CancelledFailure() when cancelled != null:
return cancelled(_that.detail,_that.error);case NotFoundFailure() when notFound != null:
return notFound(_that.detail,_that.error);case InvalidDataFailure() when invalidData != null:
return invalidData(_that.detail,_that.error);case OperationFailure() when operationFailed != null:
return operationFailed(_that.detail,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class CancelledFailure extends AppFailure {
  const CancelledFailure(this.detail, {this.error}): super._();
  

@override final  String detail;
@override final  Object? error;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancelledFailureCopyWith<CancelledFailure> get copyWith => _$CancelledFailureCopyWithImpl<CancelledFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelledFailure&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,detail,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'AppFailure.cancelled(detail: $detail, error: $error)';
}


}

/// @nodoc
abstract mixin class $CancelledFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $CancelledFailureCopyWith(CancelledFailure value, $Res Function(CancelledFailure) _then) = _$CancelledFailureCopyWithImpl;
@override @useResult
$Res call({
 String detail, Object? error
});




}
/// @nodoc
class _$CancelledFailureCopyWithImpl<$Res>
    implements $CancelledFailureCopyWith<$Res> {
  _$CancelledFailureCopyWithImpl(this._self, this._then);

  final CancelledFailure _self;
  final $Res Function(CancelledFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detail = null,Object? error = freezed,}) {
  return _then(CancelledFailure(
null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,
  ));
}


}

/// @nodoc


class NotFoundFailure extends AppFailure {
  const NotFoundFailure(this.detail, {this.error}): super._();
  

@override final  String detail;
@override final  Object? error;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotFoundFailureCopyWith<NotFoundFailure> get copyWith => _$NotFoundFailureCopyWithImpl<NotFoundFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFoundFailure&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,detail,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'AppFailure.notFound(detail: $detail, error: $error)';
}


}

/// @nodoc
abstract mixin class $NotFoundFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $NotFoundFailureCopyWith(NotFoundFailure value, $Res Function(NotFoundFailure) _then) = _$NotFoundFailureCopyWithImpl;
@override @useResult
$Res call({
 String detail, Object? error
});




}
/// @nodoc
class _$NotFoundFailureCopyWithImpl<$Res>
    implements $NotFoundFailureCopyWith<$Res> {
  _$NotFoundFailureCopyWithImpl(this._self, this._then);

  final NotFoundFailure _self;
  final $Res Function(NotFoundFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detail = null,Object? error = freezed,}) {
  return _then(NotFoundFailure(
null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,
  ));
}


}

/// @nodoc


class InvalidDataFailure extends AppFailure {
  const InvalidDataFailure(this.detail, {this.error}): super._();
  

@override final  String detail;
@override final  Object? error;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidDataFailureCopyWith<InvalidDataFailure> get copyWith => _$InvalidDataFailureCopyWithImpl<InvalidDataFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidDataFailure&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,detail,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'AppFailure.invalidData(detail: $detail, error: $error)';
}


}

/// @nodoc
abstract mixin class $InvalidDataFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $InvalidDataFailureCopyWith(InvalidDataFailure value, $Res Function(InvalidDataFailure) _then) = _$InvalidDataFailureCopyWithImpl;
@override @useResult
$Res call({
 String detail, Object? error
});




}
/// @nodoc
class _$InvalidDataFailureCopyWithImpl<$Res>
    implements $InvalidDataFailureCopyWith<$Res> {
  _$InvalidDataFailureCopyWithImpl(this._self, this._then);

  final InvalidDataFailure _self;
  final $Res Function(InvalidDataFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detail = null,Object? error = freezed,}) {
  return _then(InvalidDataFailure(
null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,
  ));
}


}

/// @nodoc


class OperationFailure extends AppFailure {
  const OperationFailure(this.detail, {this.error}): super._();
  

@override final  String detail;
@override final  Object? error;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OperationFailureCopyWith<OperationFailure> get copyWith => _$OperationFailureCopyWithImpl<OperationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OperationFailure&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,detail,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'AppFailure.operationFailed(detail: $detail, error: $error)';
}


}

/// @nodoc
abstract mixin class $OperationFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $OperationFailureCopyWith(OperationFailure value, $Res Function(OperationFailure) _then) = _$OperationFailureCopyWithImpl;
@override @useResult
$Res call({
 String detail, Object? error
});




}
/// @nodoc
class _$OperationFailureCopyWithImpl<$Res>
    implements $OperationFailureCopyWith<$Res> {
  _$OperationFailureCopyWithImpl(this._self, this._then);

  final OperationFailure _self;
  final $Res Function(OperationFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detail = null,Object? error = freezed,}) {
  return _then(OperationFailure(
null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,
  ));
}


}

// dart format on
