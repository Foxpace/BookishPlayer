// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_segments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaybackSegment {

 String get id; AudioTrack get track; String get title; int get globalStartMs; int get sourceStartMs; int get durationMs;
/// Create a copy of PlaybackSegment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackSegmentCopyWith<PlaybackSegment> get copyWith => _$PlaybackSegmentCopyWithImpl<PlaybackSegment>(this as PlaybackSegment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackSegment&&(identical(other.id, id) || other.id == id)&&(identical(other.track, track) || other.track == track)&&(identical(other.title, title) || other.title == title)&&(identical(other.globalStartMs, globalStartMs) || other.globalStartMs == globalStartMs)&&(identical(other.sourceStartMs, sourceStartMs) || other.sourceStartMs == sourceStartMs)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}


@override
int get hashCode => Object.hash(runtimeType,id,track,title,globalStartMs,sourceStartMs,durationMs);

@override
String toString() {
  return 'PlaybackSegment(id: $id, track: $track, title: $title, globalStartMs: $globalStartMs, sourceStartMs: $sourceStartMs, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class $PlaybackSegmentCopyWith<$Res>  {
  factory $PlaybackSegmentCopyWith(PlaybackSegment value, $Res Function(PlaybackSegment) _then) = _$PlaybackSegmentCopyWithImpl;
@useResult
$Res call({
 String id, AudioTrack track, String title, int globalStartMs, int sourceStartMs, int durationMs
});


$AudioTrackCopyWith<$Res> get track;

}
/// @nodoc
class _$PlaybackSegmentCopyWithImpl<$Res>
    implements $PlaybackSegmentCopyWith<$Res> {
  _$PlaybackSegmentCopyWithImpl(this._self, this._then);

  final PlaybackSegment _self;
  final $Res Function(PlaybackSegment) _then;

/// Create a copy of PlaybackSegment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? track = null,Object? title = null,Object? globalStartMs = null,Object? sourceStartMs = null,Object? durationMs = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,track: null == track ? _self.track : track // ignore: cast_nullable_to_non_nullable
as AudioTrack,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,globalStartMs: null == globalStartMs ? _self.globalStartMs : globalStartMs // ignore: cast_nullable_to_non_nullable
as int,sourceStartMs: null == sourceStartMs ? _self.sourceStartMs : sourceStartMs // ignore: cast_nullable_to_non_nullable
as int,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PlaybackSegment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudioTrackCopyWith<$Res> get track {
  
  return $AudioTrackCopyWith<$Res>(_self.track, (value) {
    return _then(_self.copyWith(track: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaybackSegment].
extension PlaybackSegmentPatterns on PlaybackSegment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaybackSegment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaybackSegment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaybackSegment value)  $default,){
final _that = this;
switch (_that) {
case _PlaybackSegment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaybackSegment value)?  $default,){
final _that = this;
switch (_that) {
case _PlaybackSegment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  AudioTrack track,  String title,  int globalStartMs,  int sourceStartMs,  int durationMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaybackSegment() when $default != null:
return $default(_that.id,_that.track,_that.title,_that.globalStartMs,_that.sourceStartMs,_that.durationMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  AudioTrack track,  String title,  int globalStartMs,  int sourceStartMs,  int durationMs)  $default,) {final _that = this;
switch (_that) {
case _PlaybackSegment():
return $default(_that.id,_that.track,_that.title,_that.globalStartMs,_that.sourceStartMs,_that.durationMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  AudioTrack track,  String title,  int globalStartMs,  int sourceStartMs,  int durationMs)?  $default,) {final _that = this;
switch (_that) {
case _PlaybackSegment() when $default != null:
return $default(_that.id,_that.track,_that.title,_that.globalStartMs,_that.sourceStartMs,_that.durationMs);case _:
  return null;

}
}

}

/// @nodoc


class _PlaybackSegment implements PlaybackSegment {
  const _PlaybackSegment({required this.id, required this.track, required this.title, required this.globalStartMs, required this.sourceStartMs, required this.durationMs});
  

@override final  String id;
@override final  AudioTrack track;
@override final  String title;
@override final  int globalStartMs;
@override final  int sourceStartMs;
@override final  int durationMs;

/// Create a copy of PlaybackSegment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackSegmentCopyWith<_PlaybackSegment> get copyWith => __$PlaybackSegmentCopyWithImpl<_PlaybackSegment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackSegment&&(identical(other.id, id) || other.id == id)&&(identical(other.track, track) || other.track == track)&&(identical(other.title, title) || other.title == title)&&(identical(other.globalStartMs, globalStartMs) || other.globalStartMs == globalStartMs)&&(identical(other.sourceStartMs, sourceStartMs) || other.sourceStartMs == sourceStartMs)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}


@override
int get hashCode => Object.hash(runtimeType,id,track,title,globalStartMs,sourceStartMs,durationMs);

@override
String toString() {
  return 'PlaybackSegment(id: $id, track: $track, title: $title, globalStartMs: $globalStartMs, sourceStartMs: $sourceStartMs, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class _$PlaybackSegmentCopyWith<$Res> implements $PlaybackSegmentCopyWith<$Res> {
  factory _$PlaybackSegmentCopyWith(_PlaybackSegment value, $Res Function(_PlaybackSegment) _then) = __$PlaybackSegmentCopyWithImpl;
@override @useResult
$Res call({
 String id, AudioTrack track, String title, int globalStartMs, int sourceStartMs, int durationMs
});


@override $AudioTrackCopyWith<$Res> get track;

}
/// @nodoc
class __$PlaybackSegmentCopyWithImpl<$Res>
    implements _$PlaybackSegmentCopyWith<$Res> {
  __$PlaybackSegmentCopyWithImpl(this._self, this._then);

  final _PlaybackSegment _self;
  final $Res Function(_PlaybackSegment) _then;

/// Create a copy of PlaybackSegment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? track = null,Object? title = null,Object? globalStartMs = null,Object? sourceStartMs = null,Object? durationMs = null,}) {
  return _then(_PlaybackSegment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,track: null == track ? _self.track : track // ignore: cast_nullable_to_non_nullable
as AudioTrack,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,globalStartMs: null == globalStartMs ? _self.globalStartMs : globalStartMs // ignore: cast_nullable_to_non_nullable
as int,sourceStartMs: null == sourceStartMs ? _self.sourceStartMs : sourceStartMs // ignore: cast_nullable_to_non_nullable
as int,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PlaybackSegment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudioTrackCopyWith<$Res> get track {
  
  return $AudioTrackCopyWith<$Res>(_self.track, (value) {
    return _then(_self.copyWith(track: value));
  });
}
}

// dart format on
