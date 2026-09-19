// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcription_preview_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TranscriptionPreviewState {

 TranscriptionDraft get draft; String get text; TranscriptionPreviewStatus get status; TranscriptionPreviewEffect? get effect; int get effectRevision;
/// Create a copy of TranscriptionPreviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptionPreviewStateCopyWith<TranscriptionPreviewState> get copyWith => _$TranscriptionPreviewStateCopyWithImpl<TranscriptionPreviewState>(this as TranscriptionPreviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptionPreviewState&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.text, text) || other.text == text)&&(identical(other.status, status) || other.status == status)&&(identical(other.effect, effect) || other.effect == effect)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,draft,text,status,effect,effectRevision);

@override
String toString() {
  return 'TranscriptionPreviewState(draft: $draft, text: $text, status: $status, effect: $effect, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class $TranscriptionPreviewStateCopyWith<$Res>  {
  factory $TranscriptionPreviewStateCopyWith(TranscriptionPreviewState value, $Res Function(TranscriptionPreviewState) _then) = _$TranscriptionPreviewStateCopyWithImpl;
@useResult
$Res call({
 TranscriptionDraft draft, String text, TranscriptionPreviewStatus status, TranscriptionPreviewEffect? effect, int effectRevision
});


$TranscriptionDraftCopyWith<$Res> get draft;

}
/// @nodoc
class _$TranscriptionPreviewStateCopyWithImpl<$Res>
    implements $TranscriptionPreviewStateCopyWith<$Res> {
  _$TranscriptionPreviewStateCopyWithImpl(this._self, this._then);

  final TranscriptionPreviewState _self;
  final $Res Function(TranscriptionPreviewState) _then;

/// Create a copy of TranscriptionPreviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draft = null,Object? text = null,Object? status = null,Object? effect = freezed,Object? effectRevision = null,}) {
  return _then(_self.copyWith(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as TranscriptionDraft,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TranscriptionPreviewStatus,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as TranscriptionPreviewEffect?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TranscriptionPreviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranscriptionDraftCopyWith<$Res> get draft {
  
  return $TranscriptionDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [TranscriptionPreviewState].
extension TranscriptionPreviewStatePatterns on TranscriptionPreviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranscriptionPreviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranscriptionPreviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranscriptionPreviewState value)  $default,){
final _that = this;
switch (_that) {
case _TranscriptionPreviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranscriptionPreviewState value)?  $default,){
final _that = this;
switch (_that) {
case _TranscriptionPreviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TranscriptionDraft draft,  String text,  TranscriptionPreviewStatus status,  TranscriptionPreviewEffect? effect,  int effectRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranscriptionPreviewState() when $default != null:
return $default(_that.draft,_that.text,_that.status,_that.effect,_that.effectRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TranscriptionDraft draft,  String text,  TranscriptionPreviewStatus status,  TranscriptionPreviewEffect? effect,  int effectRevision)  $default,) {final _that = this;
switch (_that) {
case _TranscriptionPreviewState():
return $default(_that.draft,_that.text,_that.status,_that.effect,_that.effectRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TranscriptionDraft draft,  String text,  TranscriptionPreviewStatus status,  TranscriptionPreviewEffect? effect,  int effectRevision)?  $default,) {final _that = this;
switch (_that) {
case _TranscriptionPreviewState() when $default != null:
return $default(_that.draft,_that.text,_that.status,_that.effect,_that.effectRevision);case _:
  return null;

}
}

}

/// @nodoc


class _TranscriptionPreviewState implements TranscriptionPreviewState {
  const _TranscriptionPreviewState({required this.draft, required this.text, this.status = TranscriptionPreviewStatus.ready, this.effect, this.effectRevision = 0});
  

@override final  TranscriptionDraft draft;
@override final  String text;
@override@JsonKey() final  TranscriptionPreviewStatus status;
@override final  TranscriptionPreviewEffect? effect;
@override@JsonKey() final  int effectRevision;

/// Create a copy of TranscriptionPreviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptionPreviewStateCopyWith<_TranscriptionPreviewState> get copyWith => __$TranscriptionPreviewStateCopyWithImpl<_TranscriptionPreviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranscriptionPreviewState&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.text, text) || other.text == text)&&(identical(other.status, status) || other.status == status)&&(identical(other.effect, effect) || other.effect == effect)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,draft,text,status,effect,effectRevision);

@override
String toString() {
  return 'TranscriptionPreviewState(draft: $draft, text: $text, status: $status, effect: $effect, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class _$TranscriptionPreviewStateCopyWith<$Res> implements $TranscriptionPreviewStateCopyWith<$Res> {
  factory _$TranscriptionPreviewStateCopyWith(_TranscriptionPreviewState value, $Res Function(_TranscriptionPreviewState) _then) = __$TranscriptionPreviewStateCopyWithImpl;
@override @useResult
$Res call({
 TranscriptionDraft draft, String text, TranscriptionPreviewStatus status, TranscriptionPreviewEffect? effect, int effectRevision
});


@override $TranscriptionDraftCopyWith<$Res> get draft;

}
/// @nodoc
class __$TranscriptionPreviewStateCopyWithImpl<$Res>
    implements _$TranscriptionPreviewStateCopyWith<$Res> {
  __$TranscriptionPreviewStateCopyWithImpl(this._self, this._then);

  final _TranscriptionPreviewState _self;
  final $Res Function(_TranscriptionPreviewState) _then;

/// Create a copy of TranscriptionPreviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? text = null,Object? status = null,Object? effect = freezed,Object? effectRevision = null,}) {
  return _then(_TranscriptionPreviewState(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as TranscriptionDraft,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TranscriptionPreviewStatus,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as TranscriptionPreviewEffect?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TranscriptionPreviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranscriptionDraftCopyWith<$Res> get draft {
  
  return $TranscriptionDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
