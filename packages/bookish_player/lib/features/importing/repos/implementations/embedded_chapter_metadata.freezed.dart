// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_chapter_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmbeddedChapterMetadata {

 String get title; int get startMs;
/// Create a copy of EmbeddedChapterMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmbeddedChapterMetadataCopyWith<EmbeddedChapterMetadata> get copyWith => _$EmbeddedChapterMetadataCopyWithImpl<EmbeddedChapterMetadata>(this as EmbeddedChapterMetadata, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmbeddedChapterMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.startMs, startMs) || other.startMs == startMs));
}


@override
int get hashCode => Object.hash(runtimeType,title,startMs);

@override
String toString() {
  return 'EmbeddedChapterMetadata(title: $title, startMs: $startMs)';
}


}

/// @nodoc
abstract mixin class $EmbeddedChapterMetadataCopyWith<$Res>  {
  factory $EmbeddedChapterMetadataCopyWith(EmbeddedChapterMetadata value, $Res Function(EmbeddedChapterMetadata) _then) = _$EmbeddedChapterMetadataCopyWithImpl;
@useResult
$Res call({
 String title, int startMs
});




}
/// @nodoc
class _$EmbeddedChapterMetadataCopyWithImpl<$Res>
    implements $EmbeddedChapterMetadataCopyWith<$Res> {
  _$EmbeddedChapterMetadataCopyWithImpl(this._self, this._then);

  final EmbeddedChapterMetadata _self;
  final $Res Function(EmbeddedChapterMetadata) _then;

/// Create a copy of EmbeddedChapterMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? startMs = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startMs: null == startMs ? _self.startMs : startMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EmbeddedChapterMetadata].
extension EmbeddedChapterMetadataPatterns on EmbeddedChapterMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmbeddedChapterMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmbeddedChapterMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmbeddedChapterMetadata value)  $default,){
final _that = this;
switch (_that) {
case _EmbeddedChapterMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmbeddedChapterMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _EmbeddedChapterMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  int startMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmbeddedChapterMetadata() when $default != null:
return $default(_that.title,_that.startMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  int startMs)  $default,) {final _that = this;
switch (_that) {
case _EmbeddedChapterMetadata():
return $default(_that.title,_that.startMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  int startMs)?  $default,) {final _that = this;
switch (_that) {
case _EmbeddedChapterMetadata() when $default != null:
return $default(_that.title,_that.startMs);case _:
  return null;

}
}

}

/// @nodoc


class _EmbeddedChapterMetadata implements EmbeddedChapterMetadata {
  const _EmbeddedChapterMetadata({required this.title, required this.startMs});
  

@override final  String title;
@override final  int startMs;

/// Create a copy of EmbeddedChapterMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmbeddedChapterMetadataCopyWith<_EmbeddedChapterMetadata> get copyWith => __$EmbeddedChapterMetadataCopyWithImpl<_EmbeddedChapterMetadata>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmbeddedChapterMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.startMs, startMs) || other.startMs == startMs));
}


@override
int get hashCode => Object.hash(runtimeType,title,startMs);

@override
String toString() {
  return 'EmbeddedChapterMetadata(title: $title, startMs: $startMs)';
}


}

/// @nodoc
abstract mixin class _$EmbeddedChapterMetadataCopyWith<$Res> implements $EmbeddedChapterMetadataCopyWith<$Res> {
  factory _$EmbeddedChapterMetadataCopyWith(_EmbeddedChapterMetadata value, $Res Function(_EmbeddedChapterMetadata) _then) = __$EmbeddedChapterMetadataCopyWithImpl;
@override @useResult
$Res call({
 String title, int startMs
});




}
/// @nodoc
class __$EmbeddedChapterMetadataCopyWithImpl<$Res>
    implements _$EmbeddedChapterMetadataCopyWith<$Res> {
  __$EmbeddedChapterMetadataCopyWithImpl(this._self, this._then);

  final _EmbeddedChapterMetadata _self;
  final $Res Function(_EmbeddedChapterMetadata) _then;

/// Create a copy of EmbeddedChapterMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? startMs = null,}) {
  return _then(_EmbeddedChapterMetadata(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startMs: null == startMs ? _self.startMs : startMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
