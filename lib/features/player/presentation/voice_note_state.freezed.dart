// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_note_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoiceNoteState {

 VoiceNoteStatus get status; String get text; String? get message;
/// Create a copy of VoiceNoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceNoteStateCopyWith<VoiceNoteState> get copyWith => _$VoiceNoteStateCopyWithImpl<VoiceNoteState>(this as VoiceNoteState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceNoteState&&(identical(other.status, status) || other.status == status)&&(identical(other.text, text) || other.text == text)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,text,message);

@override
String toString() {
  return 'VoiceNoteState(status: $status, text: $text, message: $message)';
}


}

/// @nodoc
abstract mixin class $VoiceNoteStateCopyWith<$Res>  {
  factory $VoiceNoteStateCopyWith(VoiceNoteState value, $Res Function(VoiceNoteState) _then) = _$VoiceNoteStateCopyWithImpl;
@useResult
$Res call({
 VoiceNoteStatus status, String text, String? message
});




}
/// @nodoc
class _$VoiceNoteStateCopyWithImpl<$Res>
    implements $VoiceNoteStateCopyWith<$Res> {
  _$VoiceNoteStateCopyWithImpl(this._self, this._then);

  final VoiceNoteState _self;
  final $Res Function(VoiceNoteState) _then;

/// Create a copy of VoiceNoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? text = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoiceNoteStatus,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoiceNoteState].
extension VoiceNoteStatePatterns on VoiceNoteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoiceNoteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoiceNoteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoiceNoteState value)  $default,){
final _that = this;
switch (_that) {
case _VoiceNoteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoiceNoteState value)?  $default,){
final _that = this;
switch (_that) {
case _VoiceNoteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VoiceNoteStatus status,  String text,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoiceNoteState() when $default != null:
return $default(_that.status,_that.text,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VoiceNoteStatus status,  String text,  String? message)  $default,) {final _that = this;
switch (_that) {
case _VoiceNoteState():
return $default(_that.status,_that.text,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VoiceNoteStatus status,  String text,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _VoiceNoteState() when $default != null:
return $default(_that.status,_that.text,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _VoiceNoteState implements VoiceNoteState {
  const _VoiceNoteState({this.status = VoiceNoteStatus.idle, this.text = '', this.message});
  

@override@JsonKey() final  VoiceNoteStatus status;
@override@JsonKey() final  String text;
@override final  String? message;

/// Create a copy of VoiceNoteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoiceNoteStateCopyWith<_VoiceNoteState> get copyWith => __$VoiceNoteStateCopyWithImpl<_VoiceNoteState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoiceNoteState&&(identical(other.status, status) || other.status == status)&&(identical(other.text, text) || other.text == text)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,text,message);

@override
String toString() {
  return 'VoiceNoteState(status: $status, text: $text, message: $message)';
}


}

/// @nodoc
abstract mixin class _$VoiceNoteStateCopyWith<$Res> implements $VoiceNoteStateCopyWith<$Res> {
  factory _$VoiceNoteStateCopyWith(_VoiceNoteState value, $Res Function(_VoiceNoteState) _then) = __$VoiceNoteStateCopyWithImpl;
@override @useResult
$Res call({
 VoiceNoteStatus status, String text, String? message
});




}
/// @nodoc
class __$VoiceNoteStateCopyWithImpl<$Res>
    implements _$VoiceNoteStateCopyWith<$Res> {
  __$VoiceNoteStateCopyWithImpl(this._self, this._then);

  final _VoiceNoteState _self;
  final $Res Function(_VoiceNoteState) _then;

/// Create a copy of VoiceNoteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? text = null,Object? message = freezed,}) {
  return _then(_VoiceNoteState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoiceNoteStatus,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
