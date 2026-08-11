// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookMetadata {

 String get id; String get fingerprint; String get title; int get durationMs; DateTime get createdAt; String? get activeBookId; String get author; String get series; String get narrator; int? get year; String get folder; double? get seriesPosition; DateTime? get completedAt; String? get artworkPath; bool get artworkScanned; List<AudioChapter> get chapters;
/// Create a copy of BookMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookMetadataCopyWith<BookMetadata> get copyWith => _$BookMetadataCopyWithImpl<BookMetadata>(this as BookMetadata, _$identity);

  /// Serializes this BookMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookMetadata&&(identical(other.id, id) || other.id == id)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint)&&(identical(other.title, title) || other.title == title)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.activeBookId, activeBookId) || other.activeBookId == activeBookId)&&(identical(other.author, author) || other.author == author)&&(identical(other.series, series) || other.series == series)&&(identical(other.narrator, narrator) || other.narrator == narrator)&&(identical(other.year, year) || other.year == year)&&(identical(other.folder, folder) || other.folder == folder)&&(identical(other.seriesPosition, seriesPosition) || other.seriesPosition == seriesPosition)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.artworkPath, artworkPath) || other.artworkPath == artworkPath)&&(identical(other.artworkScanned, artworkScanned) || other.artworkScanned == artworkScanned)&&const DeepCollectionEquality().equals(other.chapters, chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fingerprint,title,durationMs,createdAt,activeBookId,author,series,narrator,year,folder,seriesPosition,completedAt,artworkPath,artworkScanned,const DeepCollectionEquality().hash(chapters));

@override
String toString() {
  return 'BookMetadata(id: $id, fingerprint: $fingerprint, title: $title, durationMs: $durationMs, createdAt: $createdAt, activeBookId: $activeBookId, author: $author, series: $series, narrator: $narrator, year: $year, folder: $folder, seriesPosition: $seriesPosition, completedAt: $completedAt, artworkPath: $artworkPath, artworkScanned: $artworkScanned, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $BookMetadataCopyWith<$Res>  {
  factory $BookMetadataCopyWith(BookMetadata value, $Res Function(BookMetadata) _then) = _$BookMetadataCopyWithImpl;
@useResult
$Res call({
 String id, String fingerprint, String title, int durationMs, DateTime createdAt, String? activeBookId, String author, String series, String narrator, int? year, String folder, double? seriesPosition, DateTime? completedAt, String? artworkPath, bool artworkScanned, List<AudioChapter> chapters
});




}
/// @nodoc
class _$BookMetadataCopyWithImpl<$Res>
    implements $BookMetadataCopyWith<$Res> {
  _$BookMetadataCopyWithImpl(this._self, this._then);

  final BookMetadata _self;
  final $Res Function(BookMetadata) _then;

/// Create a copy of BookMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fingerprint = null,Object? title = null,Object? durationMs = null,Object? createdAt = null,Object? activeBookId = freezed,Object? author = null,Object? series = null,Object? narrator = null,Object? year = freezed,Object? folder = null,Object? seriesPosition = freezed,Object? completedAt = freezed,Object? artworkPath = freezed,Object? artworkScanned = null,Object? chapters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,activeBookId: freezed == activeBookId ? _self.activeBookId : activeBookId // ignore: cast_nullable_to_non_nullable
as String?,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,narrator: null == narrator ? _self.narrator : narrator // ignore: cast_nullable_to_non_nullable
as String,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as String,seriesPosition: freezed == seriesPosition ? _self.seriesPosition : seriesPosition // ignore: cast_nullable_to_non_nullable
as double?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,artworkPath: freezed == artworkPath ? _self.artworkPath : artworkPath // ignore: cast_nullable_to_non_nullable
as String?,artworkScanned: null == artworkScanned ? _self.artworkScanned : artworkScanned // ignore: cast_nullable_to_non_nullable
as bool,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<AudioChapter>,
  ));
}

}


/// Adds pattern-matching-related methods to [BookMetadata].
extension BookMetadataPatterns on BookMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookMetadata value)  $default,){
final _that = this;
switch (_that) {
case _BookMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _BookMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fingerprint,  String title,  int durationMs,  DateTime createdAt,  String? activeBookId,  String author,  String series,  String narrator,  int? year,  String folder,  double? seriesPosition,  DateTime? completedAt,  String? artworkPath,  bool artworkScanned,  List<AudioChapter> chapters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookMetadata() when $default != null:
return $default(_that.id,_that.fingerprint,_that.title,_that.durationMs,_that.createdAt,_that.activeBookId,_that.author,_that.series,_that.narrator,_that.year,_that.folder,_that.seriesPosition,_that.completedAt,_that.artworkPath,_that.artworkScanned,_that.chapters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fingerprint,  String title,  int durationMs,  DateTime createdAt,  String? activeBookId,  String author,  String series,  String narrator,  int? year,  String folder,  double? seriesPosition,  DateTime? completedAt,  String? artworkPath,  bool artworkScanned,  List<AudioChapter> chapters)  $default,) {final _that = this;
switch (_that) {
case _BookMetadata():
return $default(_that.id,_that.fingerprint,_that.title,_that.durationMs,_that.createdAt,_that.activeBookId,_that.author,_that.series,_that.narrator,_that.year,_that.folder,_that.seriesPosition,_that.completedAt,_that.artworkPath,_that.artworkScanned,_that.chapters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fingerprint,  String title,  int durationMs,  DateTime createdAt,  String? activeBookId,  String author,  String series,  String narrator,  int? year,  String folder,  double? seriesPosition,  DateTime? completedAt,  String? artworkPath,  bool artworkScanned,  List<AudioChapter> chapters)?  $default,) {final _that = this;
switch (_that) {
case _BookMetadata() when $default != null:
return $default(_that.id,_that.fingerprint,_that.title,_that.durationMs,_that.createdAt,_that.activeBookId,_that.author,_that.series,_that.narrator,_that.year,_that.folder,_that.seriesPosition,_that.completedAt,_that.artworkPath,_that.artworkScanned,_that.chapters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookMetadata implements BookMetadata {
  const _BookMetadata({required this.id, required this.fingerprint, required this.title, required this.durationMs, required this.createdAt, this.activeBookId, this.author = '', this.series = '', this.narrator = '', this.year, this.folder = 'Imported', this.seriesPosition, this.completedAt, this.artworkPath, this.artworkScanned = false, final  List<AudioChapter> chapters = const <AudioChapter>[]}): _chapters = chapters;
  factory _BookMetadata.fromJson(Map<String, dynamic> json) => _$BookMetadataFromJson(json);

@override final  String id;
@override final  String fingerprint;
@override final  String title;
@override final  int durationMs;
@override final  DateTime createdAt;
@override final  String? activeBookId;
@override@JsonKey() final  String author;
@override@JsonKey() final  String series;
@override@JsonKey() final  String narrator;
@override final  int? year;
@override@JsonKey() final  String folder;
@override final  double? seriesPosition;
@override final  DateTime? completedAt;
@override final  String? artworkPath;
@override@JsonKey() final  bool artworkScanned;
 final  List<AudioChapter> _chapters;
@override@JsonKey() List<AudioChapter> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}


/// Create a copy of BookMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookMetadataCopyWith<_BookMetadata> get copyWith => __$BookMetadataCopyWithImpl<_BookMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookMetadata&&(identical(other.id, id) || other.id == id)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint)&&(identical(other.title, title) || other.title == title)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.activeBookId, activeBookId) || other.activeBookId == activeBookId)&&(identical(other.author, author) || other.author == author)&&(identical(other.series, series) || other.series == series)&&(identical(other.narrator, narrator) || other.narrator == narrator)&&(identical(other.year, year) || other.year == year)&&(identical(other.folder, folder) || other.folder == folder)&&(identical(other.seriesPosition, seriesPosition) || other.seriesPosition == seriesPosition)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.artworkPath, artworkPath) || other.artworkPath == artworkPath)&&(identical(other.artworkScanned, artworkScanned) || other.artworkScanned == artworkScanned)&&const DeepCollectionEquality().equals(other._chapters, _chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fingerprint,title,durationMs,createdAt,activeBookId,author,series,narrator,year,folder,seriesPosition,completedAt,artworkPath,artworkScanned,const DeepCollectionEquality().hash(_chapters));

@override
String toString() {
  return 'BookMetadata(id: $id, fingerprint: $fingerprint, title: $title, durationMs: $durationMs, createdAt: $createdAt, activeBookId: $activeBookId, author: $author, series: $series, narrator: $narrator, year: $year, folder: $folder, seriesPosition: $seriesPosition, completedAt: $completedAt, artworkPath: $artworkPath, artworkScanned: $artworkScanned, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$BookMetadataCopyWith<$Res> implements $BookMetadataCopyWith<$Res> {
  factory _$BookMetadataCopyWith(_BookMetadata value, $Res Function(_BookMetadata) _then) = __$BookMetadataCopyWithImpl;
@override @useResult
$Res call({
 String id, String fingerprint, String title, int durationMs, DateTime createdAt, String? activeBookId, String author, String series, String narrator, int? year, String folder, double? seriesPosition, DateTime? completedAt, String? artworkPath, bool artworkScanned, List<AudioChapter> chapters
});




}
/// @nodoc
class __$BookMetadataCopyWithImpl<$Res>
    implements _$BookMetadataCopyWith<$Res> {
  __$BookMetadataCopyWithImpl(this._self, this._then);

  final _BookMetadata _self;
  final $Res Function(_BookMetadata) _then;

/// Create a copy of BookMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fingerprint = null,Object? title = null,Object? durationMs = null,Object? createdAt = null,Object? activeBookId = freezed,Object? author = null,Object? series = null,Object? narrator = null,Object? year = freezed,Object? folder = null,Object? seriesPosition = freezed,Object? completedAt = freezed,Object? artworkPath = freezed,Object? artworkScanned = null,Object? chapters = null,}) {
  return _then(_BookMetadata(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,activeBookId: freezed == activeBookId ? _self.activeBookId : activeBookId // ignore: cast_nullable_to_non_nullable
as String?,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,narrator: null == narrator ? _self.narrator : narrator // ignore: cast_nullable_to_non_nullable
as String,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as String,seriesPosition: freezed == seriesPosition ? _self.seriesPosition : seriesPosition // ignore: cast_nullable_to_non_nullable
as double?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,artworkPath: freezed == artworkPath ? _self.artworkPath : artworkPath // ignore: cast_nullable_to_non_nullable
as String?,artworkScanned: null == artworkScanned ? _self.artworkScanned : artworkScanned // ignore: cast_nullable_to_non_nullable
as bool,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<AudioChapter>,
  ));
}


}

// dart format on
