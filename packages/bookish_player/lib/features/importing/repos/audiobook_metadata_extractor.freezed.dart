// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audiobook_metadata_extractor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportedAudiobookMetadata {

 String? get title; String? get author; String? get series; String? get narrator; int? get year;
/// Create a copy of ImportedAudiobookMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportedAudiobookMetadataCopyWith<ImportedAudiobookMetadata> get copyWith => _$ImportedAudiobookMetadataCopyWithImpl<ImportedAudiobookMetadata>(this as ImportedAudiobookMetadata, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportedAudiobookMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.series, series) || other.series == series)&&(identical(other.narrator, narrator) || other.narrator == narrator)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,title,author,series,narrator,year);

@override
String toString() {
  return 'ImportedAudiobookMetadata(title: $title, author: $author, series: $series, narrator: $narrator, year: $year)';
}


}

/// @nodoc
abstract mixin class $ImportedAudiobookMetadataCopyWith<$Res>  {
  factory $ImportedAudiobookMetadataCopyWith(ImportedAudiobookMetadata value, $Res Function(ImportedAudiobookMetadata) _then) = _$ImportedAudiobookMetadataCopyWithImpl;
@useResult
$Res call({
 String? title, String? author, String? series, String? narrator, int? year
});




}
/// @nodoc
class _$ImportedAudiobookMetadataCopyWithImpl<$Res>
    implements $ImportedAudiobookMetadataCopyWith<$Res> {
  _$ImportedAudiobookMetadataCopyWithImpl(this._self, this._then);

  final ImportedAudiobookMetadata _self;
  final $Res Function(ImportedAudiobookMetadata) _then;

/// Create a copy of ImportedAudiobookMetadata
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


/// Adds pattern-matching-related methods to [ImportedAudiobookMetadata].
extension ImportedAudiobookMetadataPatterns on ImportedAudiobookMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportedAudiobookMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportedAudiobookMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportedAudiobookMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ImportedAudiobookMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportedAudiobookMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ImportedAudiobookMetadata() when $default != null:
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
case _ImportedAudiobookMetadata() when $default != null:
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
case _ImportedAudiobookMetadata():
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
case _ImportedAudiobookMetadata() when $default != null:
return $default(_that.title,_that.author,_that.series,_that.narrator,_that.year);case _:
  return null;

}
}

}

/// @nodoc


class _ImportedAudiobookMetadata implements ImportedAudiobookMetadata {
  const _ImportedAudiobookMetadata({this.title, this.author, this.series, this.narrator, this.year});
  

@override final  String? title;
@override final  String? author;
@override final  String? series;
@override final  String? narrator;
@override final  int? year;

/// Create a copy of ImportedAudiobookMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportedAudiobookMetadataCopyWith<_ImportedAudiobookMetadata> get copyWith => __$ImportedAudiobookMetadataCopyWithImpl<_ImportedAudiobookMetadata>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportedAudiobookMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.series, series) || other.series == series)&&(identical(other.narrator, narrator) || other.narrator == narrator)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,title,author,series,narrator,year);

@override
String toString() {
  return 'ImportedAudiobookMetadata(title: $title, author: $author, series: $series, narrator: $narrator, year: $year)';
}


}

/// @nodoc
abstract mixin class _$ImportedAudiobookMetadataCopyWith<$Res> implements $ImportedAudiobookMetadataCopyWith<$Res> {
  factory _$ImportedAudiobookMetadataCopyWith(_ImportedAudiobookMetadata value, $Res Function(_ImportedAudiobookMetadata) _then) = __$ImportedAudiobookMetadataCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? author, String? series, String? narrator, int? year
});




}
/// @nodoc
class __$ImportedAudiobookMetadataCopyWithImpl<$Res>
    implements _$ImportedAudiobookMetadataCopyWith<$Res> {
  __$ImportedAudiobookMetadataCopyWithImpl(this._self, this._then);

  final _ImportedAudiobookMetadata _self;
  final $Res Function(_ImportedAudiobookMetadata) _then;

/// Create a copy of ImportedAudiobookMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? author = freezed,Object? series = freezed,Object? narrator = freezed,Object? year = freezed,}) {
  return _then(_ImportedAudiobookMetadata(
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
