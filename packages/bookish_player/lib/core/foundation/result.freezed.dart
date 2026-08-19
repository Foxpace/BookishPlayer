// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Result<S,F> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Result<S, F>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Result<$S, $F>()';
}


}

/// @nodoc
class $ResultCopyWith<S,F,$Res>  {
$ResultCopyWith(Result<S, F> _, $Res Function(Result<S, F>) __);
}


/// Adds pattern-matching-related methods to [Result].
extension ResultPatterns<S,F> on Result<S, F> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ResultSuccess<S, F> value)?  success,TResult Function( ResultFailure<S, F> value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ResultSuccess() when success != null:
return success(_that);case ResultFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ResultSuccess<S, F> value)  success,required TResult Function( ResultFailure<S, F> value)  failure,}){
final _that = this;
switch (_that) {
case ResultSuccess():
return success(_that);case ResultFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ResultSuccess<S, F> value)?  success,TResult? Function( ResultFailure<S, F> value)?  failure,}){
final _that = this;
switch (_that) {
case ResultSuccess() when success != null:
return success(_that);case ResultFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( S value)?  success,TResult Function( F failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ResultSuccess() when success != null:
return success(_that.value);case ResultFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( S value)  success,required TResult Function( F failure)  failure,}) {final _that = this;
switch (_that) {
case ResultSuccess():
return success(_that.value);case ResultFailure():
return failure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( S value)?  success,TResult? Function( F failure)?  failure,}) {final _that = this;
switch (_that) {
case ResultSuccess() when success != null:
return success(_that.value);case ResultFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ResultSuccess<S,F> implements Result<S, F> {
  const ResultSuccess(this.value);
  

 final  S value;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultSuccessCopyWith<S, F, ResultSuccess<S, F>> get copyWith => _$ResultSuccessCopyWithImpl<S, F, ResultSuccess<S, F>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultSuccess<S, F>&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'Result<$S, $F>.success(value: $value)';
}


}

/// @nodoc
abstract mixin class $ResultSuccessCopyWith<S,F,$Res> implements $ResultCopyWith<S, F, $Res> {
  factory $ResultSuccessCopyWith(ResultSuccess<S, F> value, $Res Function(ResultSuccess<S, F>) _then) = _$ResultSuccessCopyWithImpl;
@useResult
$Res call({
 S value
});




}
/// @nodoc
class _$ResultSuccessCopyWithImpl<S,F,$Res>
    implements $ResultSuccessCopyWith<S, F, $Res> {
  _$ResultSuccessCopyWithImpl(this._self, this._then);

  final ResultSuccess<S, F> _self;
  final $Res Function(ResultSuccess<S, F>) _then;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(ResultSuccess<S, F>(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as S,
  ));
}


}

/// @nodoc


class ResultFailure<S,F> implements Result<S, F> {
  const ResultFailure(this.failure);
  

 final  F failure;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultFailureCopyWith<S, F, ResultFailure<S, F>> get copyWith => _$ResultFailureCopyWithImpl<S, F, ResultFailure<S, F>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultFailure<S, F>&&const DeepCollectionEquality().equals(other.failure, failure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(failure));

@override
String toString() {
  return 'Result<$S, $F>.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ResultFailureCopyWith<S,F,$Res> implements $ResultCopyWith<S, F, $Res> {
  factory $ResultFailureCopyWith(ResultFailure<S, F> value, $Res Function(ResultFailure<S, F>) _then) = _$ResultFailureCopyWithImpl;
@useResult
$Res call({
 F failure
});




}
/// @nodoc
class _$ResultFailureCopyWithImpl<S,F,$Res>
    implements $ResultFailureCopyWith<S, F, $Res> {
  _$ResultFailureCopyWithImpl(this._self, this._then);

  final ResultFailure<S, F> _self;
  final $Res Function(ResultFailure<S, F>) _then;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = freezed,}) {
  return _then(ResultFailure<S, F>(
freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as F,
  ));
}


}

// dart format on
