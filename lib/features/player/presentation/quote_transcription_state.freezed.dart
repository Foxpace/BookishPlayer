// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_transcription_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuoteTranscriptionState {

 QuoteTranscriptionStatus get status; QuoteTimeRange? get range; TranscriptionDraft? get draft; String? get message;
/// Create a copy of QuoteTranscriptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteTranscriptionStateCopyWith<QuoteTranscriptionState> get copyWith => _$QuoteTranscriptionStateCopyWithImpl<QuoteTranscriptionState>(this as QuoteTranscriptionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteTranscriptionState&&(identical(other.status, status) || other.status == status)&&(identical(other.range, range) || other.range == range)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,range,draft,message);

@override
String toString() {
  return 'QuoteTranscriptionState(status: $status, range: $range, draft: $draft, message: $message)';
}


}

/// @nodoc
abstract mixin class $QuoteTranscriptionStateCopyWith<$Res>  {
  factory $QuoteTranscriptionStateCopyWith(QuoteTranscriptionState value, $Res Function(QuoteTranscriptionState) _then) = _$QuoteTranscriptionStateCopyWithImpl;
@useResult
$Res call({
 QuoteTranscriptionStatus status, QuoteTimeRange? range, TranscriptionDraft? draft, String? message
});


$TranscriptionDraftCopyWith<$Res>? get draft;

}
/// @nodoc
class _$QuoteTranscriptionStateCopyWithImpl<$Res>
    implements $QuoteTranscriptionStateCopyWith<$Res> {
  _$QuoteTranscriptionStateCopyWithImpl(this._self, this._then);

  final QuoteTranscriptionState _self;
  final $Res Function(QuoteTranscriptionState) _then;

/// Create a copy of QuoteTranscriptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? range = freezed,Object? draft = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuoteTranscriptionStatus,range: freezed == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as QuoteTimeRange?,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as TranscriptionDraft?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of QuoteTranscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranscriptionDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $TranscriptionDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuoteTranscriptionState].
extension QuoteTranscriptionStatePatterns on QuoteTranscriptionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteTranscriptionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteTranscriptionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteTranscriptionState value)  $default,){
final _that = this;
switch (_that) {
case _QuoteTranscriptionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteTranscriptionState value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteTranscriptionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuoteTranscriptionStatus status,  QuoteTimeRange? range,  TranscriptionDraft? draft,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteTranscriptionState() when $default != null:
return $default(_that.status,_that.range,_that.draft,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuoteTranscriptionStatus status,  QuoteTimeRange? range,  TranscriptionDraft? draft,  String? message)  $default,) {final _that = this;
switch (_that) {
case _QuoteTranscriptionState():
return $default(_that.status,_that.range,_that.draft,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuoteTranscriptionStatus status,  QuoteTimeRange? range,  TranscriptionDraft? draft,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _QuoteTranscriptionState() when $default != null:
return $default(_that.status,_that.range,_that.draft,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _QuoteTranscriptionState implements QuoteTranscriptionState {
  const _QuoteTranscriptionState({this.status = QuoteTranscriptionStatus.idle, this.range, this.draft, this.message});
  

@override@JsonKey() final  QuoteTranscriptionStatus status;
@override final  QuoteTimeRange? range;
@override final  TranscriptionDraft? draft;
@override final  String? message;

/// Create a copy of QuoteTranscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteTranscriptionStateCopyWith<_QuoteTranscriptionState> get copyWith => __$QuoteTranscriptionStateCopyWithImpl<_QuoteTranscriptionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteTranscriptionState&&(identical(other.status, status) || other.status == status)&&(identical(other.range, range) || other.range == range)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,range,draft,message);

@override
String toString() {
  return 'QuoteTranscriptionState(status: $status, range: $range, draft: $draft, message: $message)';
}


}

/// @nodoc
abstract mixin class _$QuoteTranscriptionStateCopyWith<$Res> implements $QuoteTranscriptionStateCopyWith<$Res> {
  factory _$QuoteTranscriptionStateCopyWith(_QuoteTranscriptionState value, $Res Function(_QuoteTranscriptionState) _then) = __$QuoteTranscriptionStateCopyWithImpl;
@override @useResult
$Res call({
 QuoteTranscriptionStatus status, QuoteTimeRange? range, TranscriptionDraft? draft, String? message
});


@override $TranscriptionDraftCopyWith<$Res>? get draft;

}
/// @nodoc
class __$QuoteTranscriptionStateCopyWithImpl<$Res>
    implements _$QuoteTranscriptionStateCopyWith<$Res> {
  __$QuoteTranscriptionStateCopyWithImpl(this._self, this._then);

  final _QuoteTranscriptionState _self;
  final $Res Function(_QuoteTranscriptionState) _then;

/// Create a copy of QuoteTranscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? range = freezed,Object? draft = freezed,Object? message = freezed,}) {
  return _then(_QuoteTranscriptionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuoteTranscriptionStatus,range: freezed == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as QuoteTimeRange?,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as TranscriptionDraft?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of QuoteTranscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranscriptionDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $TranscriptionDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
