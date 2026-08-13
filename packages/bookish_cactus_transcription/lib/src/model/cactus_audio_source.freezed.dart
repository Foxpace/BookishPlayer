// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cactus_audio_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CactusAudioSource {

 List<CactusAudioTrack> get tracks;
/// Create a copy of CactusAudioSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CactusAudioSourceCopyWith<CactusAudioSource> get copyWith => _$CactusAudioSourceCopyWithImpl<CactusAudioSource>(this as CactusAudioSource, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CactusAudioSource&&const DeepCollectionEquality().equals(other.tracks, tracks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tracks));

@override
String toString() {
  return 'CactusAudioSource(tracks: $tracks)';
}


}

/// @nodoc
abstract mixin class $CactusAudioSourceCopyWith<$Res>  {
  factory $CactusAudioSourceCopyWith(CactusAudioSource value, $Res Function(CactusAudioSource) _then) = _$CactusAudioSourceCopyWithImpl;
@useResult
$Res call({
 List<CactusAudioTrack> tracks
});




}
/// @nodoc
class _$CactusAudioSourceCopyWithImpl<$Res>
    implements $CactusAudioSourceCopyWith<$Res> {
  _$CactusAudioSourceCopyWithImpl(this._self, this._then);

  final CactusAudioSource _self;
  final $Res Function(CactusAudioSource) _then;

/// Create a copy of CactusAudioSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tracks = null,}) {
  return _then(_self.copyWith(
tracks: null == tracks ? _self.tracks : tracks // ignore: cast_nullable_to_non_nullable
as List<CactusAudioTrack>,
  ));
}

}


/// Adds pattern-matching-related methods to [CactusAudioSource].
extension CactusAudioSourcePatterns on CactusAudioSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CactusAudioSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CactusAudioSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CactusAudioSource value)  $default,){
final _that = this;
switch (_that) {
case _CactusAudioSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CactusAudioSource value)?  $default,){
final _that = this;
switch (_that) {
case _CactusAudioSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CactusAudioTrack> tracks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CactusAudioSource() when $default != null:
return $default(_that.tracks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CactusAudioTrack> tracks)  $default,) {final _that = this;
switch (_that) {
case _CactusAudioSource():
return $default(_that.tracks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CactusAudioTrack> tracks)?  $default,) {final _that = this;
switch (_that) {
case _CactusAudioSource() when $default != null:
return $default(_that.tracks);case _:
  return null;

}
}

}

/// @nodoc


class _CactusAudioSource implements CactusAudioSource {
  const _CactusAudioSource({required final  List<CactusAudioTrack> tracks}): _tracks = tracks;
  

 final  List<CactusAudioTrack> _tracks;
@override List<CactusAudioTrack> get tracks {
  if (_tracks is EqualUnmodifiableListView) return _tracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tracks);
}


/// Create a copy of CactusAudioSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CactusAudioSourceCopyWith<_CactusAudioSource> get copyWith => __$CactusAudioSourceCopyWithImpl<_CactusAudioSource>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CactusAudioSource&&const DeepCollectionEquality().equals(other._tracks, _tracks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tracks));

@override
String toString() {
  return 'CactusAudioSource(tracks: $tracks)';
}


}

/// @nodoc
abstract mixin class _$CactusAudioSourceCopyWith<$Res> implements $CactusAudioSourceCopyWith<$Res> {
  factory _$CactusAudioSourceCopyWith(_CactusAudioSource value, $Res Function(_CactusAudioSource) _then) = __$CactusAudioSourceCopyWithImpl;
@override @useResult
$Res call({
 List<CactusAudioTrack> tracks
});




}
/// @nodoc
class __$CactusAudioSourceCopyWithImpl<$Res>
    implements _$CactusAudioSourceCopyWith<$Res> {
  __$CactusAudioSourceCopyWithImpl(this._self, this._then);

  final _CactusAudioSource _self;
  final $Res Function(_CactusAudioSource) _then;

/// Create a copy of CactusAudioSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tracks = null,}) {
  return _then(_CactusAudioSource(
tracks: null == tracks ? _self._tracks : tracks // ignore: cast_nullable_to_non_nullable
as List<CactusAudioTrack>,
  ));
}


}

// dart format on
