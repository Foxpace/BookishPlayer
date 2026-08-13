// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaybackPreferences {

 int get rewindSeconds; int get forwardSeconds; bool get shortenSilence; bool get voiceBoost; int get sleepFadeSeconds; int get largeSeekMinutes; bool get continueSeries; int get chapterFallbackMinutes;
/// Create a copy of PlaybackPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackPreferencesCopyWith<PlaybackPreferences> get copyWith => _$PlaybackPreferencesCopyWithImpl<PlaybackPreferences>(this as PlaybackPreferences, _$identity);

  /// Serializes this PlaybackPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackPreferences&&(identical(other.rewindSeconds, rewindSeconds) || other.rewindSeconds == rewindSeconds)&&(identical(other.forwardSeconds, forwardSeconds) || other.forwardSeconds == forwardSeconds)&&(identical(other.shortenSilence, shortenSilence) || other.shortenSilence == shortenSilence)&&(identical(other.voiceBoost, voiceBoost) || other.voiceBoost == voiceBoost)&&(identical(other.sleepFadeSeconds, sleepFadeSeconds) || other.sleepFadeSeconds == sleepFadeSeconds)&&(identical(other.largeSeekMinutes, largeSeekMinutes) || other.largeSeekMinutes == largeSeekMinutes)&&(identical(other.continueSeries, continueSeries) || other.continueSeries == continueSeries)&&(identical(other.chapterFallbackMinutes, chapterFallbackMinutes) || other.chapterFallbackMinutes == chapterFallbackMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rewindSeconds,forwardSeconds,shortenSilence,voiceBoost,sleepFadeSeconds,largeSeekMinutes,continueSeries,chapterFallbackMinutes);

@override
String toString() {
  return 'PlaybackPreferences(rewindSeconds: $rewindSeconds, forwardSeconds: $forwardSeconds, shortenSilence: $shortenSilence, voiceBoost: $voiceBoost, sleepFadeSeconds: $sleepFadeSeconds, largeSeekMinutes: $largeSeekMinutes, continueSeries: $continueSeries, chapterFallbackMinutes: $chapterFallbackMinutes)';
}


}

/// @nodoc
abstract mixin class $PlaybackPreferencesCopyWith<$Res>  {
  factory $PlaybackPreferencesCopyWith(PlaybackPreferences value, $Res Function(PlaybackPreferences) _then) = _$PlaybackPreferencesCopyWithImpl;
@useResult
$Res call({
 int rewindSeconds, int forwardSeconds, bool shortenSilence, bool voiceBoost, int sleepFadeSeconds, int largeSeekMinutes, bool continueSeries, int chapterFallbackMinutes
});




}
/// @nodoc
class _$PlaybackPreferencesCopyWithImpl<$Res>
    implements $PlaybackPreferencesCopyWith<$Res> {
  _$PlaybackPreferencesCopyWithImpl(this._self, this._then);

  final PlaybackPreferences _self;
  final $Res Function(PlaybackPreferences) _then;

/// Create a copy of PlaybackPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rewindSeconds = null,Object? forwardSeconds = null,Object? shortenSilence = null,Object? voiceBoost = null,Object? sleepFadeSeconds = null,Object? largeSeekMinutes = null,Object? continueSeries = null,Object? chapterFallbackMinutes = null,}) {
  return _then(_self.copyWith(
rewindSeconds: null == rewindSeconds ? _self.rewindSeconds : rewindSeconds // ignore: cast_nullable_to_non_nullable
as int,forwardSeconds: null == forwardSeconds ? _self.forwardSeconds : forwardSeconds // ignore: cast_nullable_to_non_nullable
as int,shortenSilence: null == shortenSilence ? _self.shortenSilence : shortenSilence // ignore: cast_nullable_to_non_nullable
as bool,voiceBoost: null == voiceBoost ? _self.voiceBoost : voiceBoost // ignore: cast_nullable_to_non_nullable
as bool,sleepFadeSeconds: null == sleepFadeSeconds ? _self.sleepFadeSeconds : sleepFadeSeconds // ignore: cast_nullable_to_non_nullable
as int,largeSeekMinutes: null == largeSeekMinutes ? _self.largeSeekMinutes : largeSeekMinutes // ignore: cast_nullable_to_non_nullable
as int,continueSeries: null == continueSeries ? _self.continueSeries : continueSeries // ignore: cast_nullable_to_non_nullable
as bool,chapterFallbackMinutes: null == chapterFallbackMinutes ? _self.chapterFallbackMinutes : chapterFallbackMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaybackPreferences].
extension PlaybackPreferencesPatterns on PlaybackPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaybackPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaybackPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaybackPreferences value)  $default,){
final _that = this;
switch (_that) {
case _PlaybackPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaybackPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _PlaybackPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rewindSeconds,  int forwardSeconds,  bool shortenSilence,  bool voiceBoost,  int sleepFadeSeconds,  int largeSeekMinutes,  bool continueSeries,  int chapterFallbackMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaybackPreferences() when $default != null:
return $default(_that.rewindSeconds,_that.forwardSeconds,_that.shortenSilence,_that.voiceBoost,_that.sleepFadeSeconds,_that.largeSeekMinutes,_that.continueSeries,_that.chapterFallbackMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rewindSeconds,  int forwardSeconds,  bool shortenSilence,  bool voiceBoost,  int sleepFadeSeconds,  int largeSeekMinutes,  bool continueSeries,  int chapterFallbackMinutes)  $default,) {final _that = this;
switch (_that) {
case _PlaybackPreferences():
return $default(_that.rewindSeconds,_that.forwardSeconds,_that.shortenSilence,_that.voiceBoost,_that.sleepFadeSeconds,_that.largeSeekMinutes,_that.continueSeries,_that.chapterFallbackMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rewindSeconds,  int forwardSeconds,  bool shortenSilence,  bool voiceBoost,  int sleepFadeSeconds,  int largeSeekMinutes,  bool continueSeries,  int chapterFallbackMinutes)?  $default,) {final _that = this;
switch (_that) {
case _PlaybackPreferences() when $default != null:
return $default(_that.rewindSeconds,_that.forwardSeconds,_that.shortenSilence,_that.voiceBoost,_that.sleepFadeSeconds,_that.largeSeekMinutes,_that.continueSeries,_that.chapterFallbackMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaybackPreferences implements PlaybackPreferences {
  const _PlaybackPreferences({this.rewindSeconds = 15, this.forwardSeconds = 15, this.shortenSilence = false, this.voiceBoost = false, this.sleepFadeSeconds = 8, this.largeSeekMinutes = 10, this.continueSeries = true, this.chapterFallbackMinutes = 0});
  factory _PlaybackPreferences.fromJson(Map<String, dynamic> json) => _$PlaybackPreferencesFromJson(json);

@override@JsonKey() final  int rewindSeconds;
@override@JsonKey() final  int forwardSeconds;
@override@JsonKey() final  bool shortenSilence;
@override@JsonKey() final  bool voiceBoost;
@override@JsonKey() final  int sleepFadeSeconds;
@override@JsonKey() final  int largeSeekMinutes;
@override@JsonKey() final  bool continueSeries;
@override@JsonKey() final  int chapterFallbackMinutes;

/// Create a copy of PlaybackPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackPreferencesCopyWith<_PlaybackPreferences> get copyWith => __$PlaybackPreferencesCopyWithImpl<_PlaybackPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaybackPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackPreferences&&(identical(other.rewindSeconds, rewindSeconds) || other.rewindSeconds == rewindSeconds)&&(identical(other.forwardSeconds, forwardSeconds) || other.forwardSeconds == forwardSeconds)&&(identical(other.shortenSilence, shortenSilence) || other.shortenSilence == shortenSilence)&&(identical(other.voiceBoost, voiceBoost) || other.voiceBoost == voiceBoost)&&(identical(other.sleepFadeSeconds, sleepFadeSeconds) || other.sleepFadeSeconds == sleepFadeSeconds)&&(identical(other.largeSeekMinutes, largeSeekMinutes) || other.largeSeekMinutes == largeSeekMinutes)&&(identical(other.continueSeries, continueSeries) || other.continueSeries == continueSeries)&&(identical(other.chapterFallbackMinutes, chapterFallbackMinutes) || other.chapterFallbackMinutes == chapterFallbackMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rewindSeconds,forwardSeconds,shortenSilence,voiceBoost,sleepFadeSeconds,largeSeekMinutes,continueSeries,chapterFallbackMinutes);

@override
String toString() {
  return 'PlaybackPreferences(rewindSeconds: $rewindSeconds, forwardSeconds: $forwardSeconds, shortenSilence: $shortenSilence, voiceBoost: $voiceBoost, sleepFadeSeconds: $sleepFadeSeconds, largeSeekMinutes: $largeSeekMinutes, continueSeries: $continueSeries, chapterFallbackMinutes: $chapterFallbackMinutes)';
}


}

/// @nodoc
abstract mixin class _$PlaybackPreferencesCopyWith<$Res> implements $PlaybackPreferencesCopyWith<$Res> {
  factory _$PlaybackPreferencesCopyWith(_PlaybackPreferences value, $Res Function(_PlaybackPreferences) _then) = __$PlaybackPreferencesCopyWithImpl;
@override @useResult
$Res call({
 int rewindSeconds, int forwardSeconds, bool shortenSilence, bool voiceBoost, int sleepFadeSeconds, int largeSeekMinutes, bool continueSeries, int chapterFallbackMinutes
});




}
/// @nodoc
class __$PlaybackPreferencesCopyWithImpl<$Res>
    implements _$PlaybackPreferencesCopyWith<$Res> {
  __$PlaybackPreferencesCopyWithImpl(this._self, this._then);

  final _PlaybackPreferences _self;
  final $Res Function(_PlaybackPreferences) _then;

/// Create a copy of PlaybackPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rewindSeconds = null,Object? forwardSeconds = null,Object? shortenSilence = null,Object? voiceBoost = null,Object? sleepFadeSeconds = null,Object? largeSeekMinutes = null,Object? continueSeries = null,Object? chapterFallbackMinutes = null,}) {
  return _then(_PlaybackPreferences(
rewindSeconds: null == rewindSeconds ? _self.rewindSeconds : rewindSeconds // ignore: cast_nullable_to_non_nullable
as int,forwardSeconds: null == forwardSeconds ? _self.forwardSeconds : forwardSeconds // ignore: cast_nullable_to_non_nullable
as int,shortenSilence: null == shortenSilence ? _self.shortenSilence : shortenSilence // ignore: cast_nullable_to_non_nullable
as bool,voiceBoost: null == voiceBoost ? _self.voiceBoost : voiceBoost // ignore: cast_nullable_to_non_nullable
as bool,sleepFadeSeconds: null == sleepFadeSeconds ? _self.sleepFadeSeconds : sleepFadeSeconds // ignore: cast_nullable_to_non_nullable
as int,largeSeekMinutes: null == largeSeekMinutes ? _self.largeSeekMinutes : largeSeekMinutes // ignore: cast_nullable_to_non_nullable
as int,continueSeries: null == continueSeries ? _self.continueSeries : continueSeries // ignore: cast_nullable_to_non_nullable
as bool,chapterFallbackMinutes: null == chapterFallbackMinutes ? _self.chapterFallbackMinutes : chapterFallbackMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
