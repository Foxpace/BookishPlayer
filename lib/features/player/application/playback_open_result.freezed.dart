// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_open_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaybackOpenResult {

 Audiobook get book; PlaybackPreferences get preferences;
/// Create a copy of PlaybackOpenResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackOpenResultCopyWith<PlaybackOpenResult> get copyWith => _$PlaybackOpenResultCopyWithImpl<PlaybackOpenResult>(this as PlaybackOpenResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackOpenResult&&(identical(other.book, book) || other.book == book)&&(identical(other.preferences, preferences) || other.preferences == preferences));
}


@override
int get hashCode => Object.hash(runtimeType,book,preferences);

@override
String toString() {
  return 'PlaybackOpenResult(book: $book, preferences: $preferences)';
}


}

/// @nodoc
abstract mixin class $PlaybackOpenResultCopyWith<$Res>  {
  factory $PlaybackOpenResultCopyWith(PlaybackOpenResult value, $Res Function(PlaybackOpenResult) _then) = _$PlaybackOpenResultCopyWithImpl;
@useResult
$Res call({
 Audiobook book, PlaybackPreferences preferences
});


$AudiobookCopyWith<$Res> get book;$PlaybackPreferencesCopyWith<$Res> get preferences;

}
/// @nodoc
class _$PlaybackOpenResultCopyWithImpl<$Res>
    implements $PlaybackOpenResultCopyWith<$Res> {
  _$PlaybackOpenResultCopyWithImpl(this._self, this._then);

  final PlaybackOpenResult _self;
  final $Res Function(PlaybackOpenResult) _then;

/// Create a copy of PlaybackOpenResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = null,Object? preferences = null,}) {
  return _then(_self.copyWith(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook,preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as PlaybackPreferences,
  ));
}
/// Create a copy of PlaybackOpenResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookCopyWith<$Res> get book {
  
  return $AudiobookCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}/// Create a copy of PlaybackOpenResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaybackPreferencesCopyWith<$Res> get preferences {
  
  return $PlaybackPreferencesCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaybackOpenResult].
extension PlaybackOpenResultPatterns on PlaybackOpenResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaybackOpenResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaybackOpenResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaybackOpenResult value)  $default,){
final _that = this;
switch (_that) {
case _PlaybackOpenResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaybackOpenResult value)?  $default,){
final _that = this;
switch (_that) {
case _PlaybackOpenResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Audiobook book,  PlaybackPreferences preferences)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaybackOpenResult() when $default != null:
return $default(_that.book,_that.preferences);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Audiobook book,  PlaybackPreferences preferences)  $default,) {final _that = this;
switch (_that) {
case _PlaybackOpenResult():
return $default(_that.book,_that.preferences);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Audiobook book,  PlaybackPreferences preferences)?  $default,) {final _that = this;
switch (_that) {
case _PlaybackOpenResult() when $default != null:
return $default(_that.book,_that.preferences);case _:
  return null;

}
}

}

/// @nodoc


class _PlaybackOpenResult implements PlaybackOpenResult {
  const _PlaybackOpenResult({required this.book, required this.preferences});
  

@override final  Audiobook book;
@override final  PlaybackPreferences preferences;

/// Create a copy of PlaybackOpenResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackOpenResultCopyWith<_PlaybackOpenResult> get copyWith => __$PlaybackOpenResultCopyWithImpl<_PlaybackOpenResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackOpenResult&&(identical(other.book, book) || other.book == book)&&(identical(other.preferences, preferences) || other.preferences == preferences));
}


@override
int get hashCode => Object.hash(runtimeType,book,preferences);

@override
String toString() {
  return 'PlaybackOpenResult(book: $book, preferences: $preferences)';
}


}

/// @nodoc
abstract mixin class _$PlaybackOpenResultCopyWith<$Res> implements $PlaybackOpenResultCopyWith<$Res> {
  factory _$PlaybackOpenResultCopyWith(_PlaybackOpenResult value, $Res Function(_PlaybackOpenResult) _then) = __$PlaybackOpenResultCopyWithImpl;
@override @useResult
$Res call({
 Audiobook book, PlaybackPreferences preferences
});


@override $AudiobookCopyWith<$Res> get book;@override $PlaybackPreferencesCopyWith<$Res> get preferences;

}
/// @nodoc
class __$PlaybackOpenResultCopyWithImpl<$Res>
    implements _$PlaybackOpenResultCopyWith<$Res> {
  __$PlaybackOpenResultCopyWithImpl(this._self, this._then);

  final _PlaybackOpenResult _self;
  final $Res Function(_PlaybackOpenResult) _then;

/// Create a copy of PlaybackOpenResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = null,Object? preferences = null,}) {
  return _then(_PlaybackOpenResult(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook,preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as PlaybackPreferences,
  ));
}

/// Create a copy of PlaybackOpenResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookCopyWith<$Res> get book {
  
  return $AudiobookCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}/// Create a copy of PlaybackOpenResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaybackPreferencesCopyWith<$Res> get preferences {
  
  return $PlaybackPreferencesCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}
}

// dart format on
