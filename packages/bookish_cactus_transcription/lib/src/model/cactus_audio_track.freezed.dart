// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cactus_audio_track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CactusAudioTrack {

 String get filePath; int get durationMs;
/// Create a copy of CactusAudioTrack
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CactusAudioTrackCopyWith<CactusAudioTrack> get copyWith => _$CactusAudioTrackCopyWithImpl<CactusAudioTrack>(this as CactusAudioTrack, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CactusAudioTrack&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}


@override
int get hashCode => Object.hash(runtimeType,filePath,durationMs);

@override
String toString() {
  return 'CactusAudioTrack(filePath: $filePath, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class $CactusAudioTrackCopyWith<$Res>  {
  factory $CactusAudioTrackCopyWith(CactusAudioTrack value, $Res Function(CactusAudioTrack) _then) = _$CactusAudioTrackCopyWithImpl;
@useResult
$Res call({
 String filePath, int durationMs
});




}
/// @nodoc
class _$CactusAudioTrackCopyWithImpl<$Res>
    implements $CactusAudioTrackCopyWith<$Res> {
  _$CactusAudioTrackCopyWithImpl(this._self, this._then);

  final CactusAudioTrack _self;
  final $Res Function(CactusAudioTrack) _then;

/// Create a copy of CactusAudioTrack
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filePath = null,Object? durationMs = null,}) {
  return _then(_self.copyWith(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CactusAudioTrack].
extension CactusAudioTrackPatterns on CactusAudioTrack {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CactusAudioTrack value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CactusAudioTrack() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CactusAudioTrack value)  $default,){
final _that = this;
switch (_that) {
case _CactusAudioTrack():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CactusAudioTrack value)?  $default,){
final _that = this;
switch (_that) {
case _CactusAudioTrack() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String filePath,  int durationMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CactusAudioTrack() when $default != null:
return $default(_that.filePath,_that.durationMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String filePath,  int durationMs)  $default,) {final _that = this;
switch (_that) {
case _CactusAudioTrack():
return $default(_that.filePath,_that.durationMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String filePath,  int durationMs)?  $default,) {final _that = this;
switch (_that) {
case _CactusAudioTrack() when $default != null:
return $default(_that.filePath,_that.durationMs);case _:
  return null;

}
}

}

/// @nodoc


class _CactusAudioTrack implements CactusAudioTrack {
  const _CactusAudioTrack({required this.filePath, required this.durationMs});
  

@override final  String filePath;
@override final  int durationMs;

/// Create a copy of CactusAudioTrack
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CactusAudioTrackCopyWith<_CactusAudioTrack> get copyWith => __$CactusAudioTrackCopyWithImpl<_CactusAudioTrack>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CactusAudioTrack&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}


@override
int get hashCode => Object.hash(runtimeType,filePath,durationMs);

@override
String toString() {
  return 'CactusAudioTrack(filePath: $filePath, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class _$CactusAudioTrackCopyWith<$Res> implements $CactusAudioTrackCopyWith<$Res> {
  factory _$CactusAudioTrackCopyWith(_CactusAudioTrack value, $Res Function(_CactusAudioTrack) _then) = __$CactusAudioTrackCopyWithImpl;
@override @useResult
$Res call({
 String filePath, int durationMs
});




}
/// @nodoc
class __$CactusAudioTrackCopyWithImpl<$Res>
    implements _$CactusAudioTrackCopyWith<$Res> {
  __$CactusAudioTrackCopyWithImpl(this._self, this._then);

  final _CactusAudioTrack _self;
  final $Res Function(_CactusAudioTrack) _then;

/// Create a copy of CactusAudioTrack
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filePath = null,Object? durationMs = null,}) {
  return _then(_CactusAudioTrack(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
