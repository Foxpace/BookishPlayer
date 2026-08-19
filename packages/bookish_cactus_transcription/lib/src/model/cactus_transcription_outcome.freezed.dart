// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cactus_transcription_outcome.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CactusTranscriptionOutcome {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CactusTranscriptionOutcome);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CactusTranscriptionOutcome()';
}


}

/// @nodoc
class $CactusTranscriptionOutcomeCopyWith<$Res>  {
$CactusTranscriptionOutcomeCopyWith(CactusTranscriptionOutcome _, $Res Function(CactusTranscriptionOutcome) __);
}


/// Adds pattern-matching-related methods to [CactusTranscriptionOutcome].
extension CactusTranscriptionOutcomePatterns on CactusTranscriptionOutcome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CactusTranscriptionSucceeded value)?  success,TResult Function( CactusTranscriptionFailed value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CactusTranscriptionSucceeded() when success != null:
return success(_that);case CactusTranscriptionFailed() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CactusTranscriptionSucceeded value)  success,required TResult Function( CactusTranscriptionFailed value)  failure,}){
final _that = this;
switch (_that) {
case CactusTranscriptionSucceeded():
return success(_that);case CactusTranscriptionFailed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CactusTranscriptionSucceeded value)?  success,TResult? Function( CactusTranscriptionFailed value)?  failure,}){
final _that = this;
switch (_that) {
case CactusTranscriptionSucceeded() when success != null:
return success(_that);case CactusTranscriptionFailed() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CactusTranscriptionSucceeded() when success != null:
return success(_that.text);case CactusTranscriptionFailed() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CactusTranscriptionSucceeded():
return success(_that.text);case CactusTranscriptionFailed():
return failure(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CactusTranscriptionSucceeded() when success != null:
return success(_that.text);case CactusTranscriptionFailed() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CactusTranscriptionSucceeded implements CactusTranscriptionOutcome {
  const CactusTranscriptionSucceeded(this.text);
  

 final  String text;

/// Create a copy of CactusTranscriptionOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CactusTranscriptionSucceededCopyWith<CactusTranscriptionSucceeded> get copyWith => _$CactusTranscriptionSucceededCopyWithImpl<CactusTranscriptionSucceeded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CactusTranscriptionSucceeded&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'CactusTranscriptionOutcome.success(text: $text)';
}


}

/// @nodoc
abstract mixin class $CactusTranscriptionSucceededCopyWith<$Res> implements $CactusTranscriptionOutcomeCopyWith<$Res> {
  factory $CactusTranscriptionSucceededCopyWith(CactusTranscriptionSucceeded value, $Res Function(CactusTranscriptionSucceeded) _then) = _$CactusTranscriptionSucceededCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$CactusTranscriptionSucceededCopyWithImpl<$Res>
    implements $CactusTranscriptionSucceededCopyWith<$Res> {
  _$CactusTranscriptionSucceededCopyWithImpl(this._self, this._then);

  final CactusTranscriptionSucceeded _self;
  final $Res Function(CactusTranscriptionSucceeded) _then;

/// Create a copy of CactusTranscriptionOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(CactusTranscriptionSucceeded(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CactusTranscriptionFailed implements CactusTranscriptionOutcome {
  const CactusTranscriptionFailed(this.message);
  

 final  String message;

/// Create a copy of CactusTranscriptionOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CactusTranscriptionFailedCopyWith<CactusTranscriptionFailed> get copyWith => _$CactusTranscriptionFailedCopyWithImpl<CactusTranscriptionFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CactusTranscriptionFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CactusTranscriptionOutcome.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CactusTranscriptionFailedCopyWith<$Res> implements $CactusTranscriptionOutcomeCopyWith<$Res> {
  factory $CactusTranscriptionFailedCopyWith(CactusTranscriptionFailed value, $Res Function(CactusTranscriptionFailed) _then) = _$CactusTranscriptionFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CactusTranscriptionFailedCopyWithImpl<$Res>
    implements $CactusTranscriptionFailedCopyWith<$Res> {
  _$CactusTranscriptionFailedCopyWithImpl(this._self, this._then);

  final CactusTranscriptionFailed _self;
  final $Res Function(CactusTranscriptionFailed) _then;

/// Create a copy of CactusTranscriptionOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CactusTranscriptionFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
