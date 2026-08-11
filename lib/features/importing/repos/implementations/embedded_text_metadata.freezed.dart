// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_text_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmbeddedTextMetadata {

 String? get title; String? get author; String? get series; String? get narrator; int? get year;
/// Create a copy of EmbeddedTextMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmbeddedTextMetadataCopyWith<EmbeddedTextMetadata> get copyWith => _$EmbeddedTextMetadataCopyWithImpl<EmbeddedTextMetadata>(this as EmbeddedTextMetadata, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmbeddedTextMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.series, series) || other.series == series)&&(identical(other.narrator, narrator) || other.narrator == narrator)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,title,author,series,narrator,year);

@override
String toString() {
  return 'EmbeddedTextMetadata(title: $title, author: $author, series: $series, narrator: $narrator, year: $year)';
}


}

/// @nodoc
abstract mixin class $EmbeddedTextMetadataCopyWith<$Res>  {
  factory $EmbeddedTextMetadataCopyWith(EmbeddedTextMetadata value, $Res Function(EmbeddedTextMetadata) _then) = _$EmbeddedTextMetadataCopyWithImpl;
@useResult
$Res call({
 String? title, String? author, String? series, String? narrator, int? year
});




}
/// @nodoc
class _$EmbeddedTextMetadataCopyWithImpl<$Res>
    implements $EmbeddedTextMetadataCopyWith<$Res> {
  _$EmbeddedTextMetadataCopyWithImpl(this._self, this._then);

  final EmbeddedTextMetadata _self;
  final $Res Function(EmbeddedTextMetadata) _then;

/// Create a copy of EmbeddedTextMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? author = freezed,Object? series = freezed,Object? narrator = freezed,Object? year = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,series: freezed == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String?,narrator: freezed == narrator ? _self.narrator : narrator // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmbeddedTextMetadata].
extension EmbeddedTextMetadataPatterns on EmbeddedTextMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmbeddedTextMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmbeddedTextMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmbeddedTextMetadata value)  $default,){
final _that = this;
switch (_that) {
case _EmbeddedTextMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmbeddedTextMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _EmbeddedTextMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? author,  String? series,  String? narrator,  int? year)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmbeddedTextMetadata() when $default != null:
return $default(_that.title,_that.author,_that.series,_that.narrator,_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? author,  String? series,  String? narrator,  int? year)  $default,) {final _that = this;
switch (_that) {
case _EmbeddedTextMetadata():
return $default(_that.title,_that.author,_that.series,_that.narrator,_that.year);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? author,  String? series,  String? narrator,  int? year)?  $default,) {final _that = this;
switch (_that) {
case _EmbeddedTextMetadata() when $default != null:
return $default(_that.title,_that.author,_that.series,_that.narrator,_that.year);case _:
  return null;

}
}

}

/// @nodoc


class _EmbeddedTextMetadata implements EmbeddedTextMetadata {
  const _EmbeddedTextMetadata({this.title, this.author, this.series, this.narrator, this.year});
  

@override final  String? title;
@override final  String? author;
@override final  String? series;
@override final  String? narrator;
@override final  int? year;

/// Create a copy of EmbeddedTextMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmbeddedTextMetadataCopyWith<_EmbeddedTextMetadata> get copyWith => __$EmbeddedTextMetadataCopyWithImpl<_EmbeddedTextMetadata>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmbeddedTextMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.series, series) || other.series == series)&&(identical(other.narrator, narrator) || other.narrator == narrator)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,title,author,series,narrator,year);

@override
String toString() {
  return 'EmbeddedTextMetadata(title: $title, author: $author, series: $series, narrator: $narrator, year: $year)';
}


}

/// @nodoc
abstract mixin class _$EmbeddedTextMetadataCopyWith<$Res> implements $EmbeddedTextMetadataCopyWith<$Res> {
  factory _$EmbeddedTextMetadataCopyWith(_EmbeddedTextMetadata value, $Res Function(_EmbeddedTextMetadata) _then) = __$EmbeddedTextMetadataCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? author, String? series, String? narrator, int? year
});




}
/// @nodoc
class __$EmbeddedTextMetadataCopyWithImpl<$Res>
    implements _$EmbeddedTextMetadataCopyWith<$Res> {
  __$EmbeddedTextMetadataCopyWithImpl(this._self, this._then);

  final _EmbeddedTextMetadata _self;
  final $Res Function(_EmbeddedTextMetadata) _then;

/// Create a copy of EmbeddedTextMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? author = freezed,Object? series = freezed,Object? narrator = freezed,Object? year = freezed,}) {
  return _then(_EmbeddedTextMetadata(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,series: freezed == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String?,narrator: freezed == narrator ? _self.narrator : narrator // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
