// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audiobook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Audiobook {

 String get id; String get title; String get filePath; int get durationMs; DateTime get addedAt; String get metadataId; String get author; String get series; String get narrator; int? get year; String get folder; String? get artworkPath; bool get artworkScanned; int get positionMs; DateTime? get lastPlayedAt; double get playbackSpeed; bool get isFavorite; ListeningStatus? get statusOverride; double? get seriesPosition; DateTime? get completedAt; List<AudioTrack> get tracks; List<AudioChapter> get chapters;
/// Create a copy of Audiobook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudiobookCopyWith<Audiobook> get copyWith => _$AudiobookCopyWithImpl<Audiobook>(this as Audiobook, _$identity);

  /// Serializes this Audiobook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Audiobook&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt)&&(identical(other.metadataId, metadataId) || other.metadataId == metadataId)&&(identical(other.author, author) || other.author == author)&&(identical(other.series, series) || other.series == series)&&(identical(other.narrator, narrator) || other.narrator == narrator)&&(identical(other.year, year) || other.year == year)&&(identical(other.folder, folder) || other.folder == folder)&&(identical(other.artworkPath, artworkPath) || other.artworkPath == artworkPath)&&(identical(other.artworkScanned, artworkScanned) || other.artworkScanned == artworkScanned)&&(identical(other.positionMs, positionMs) || other.positionMs == positionMs)&&(identical(other.lastPlayedAt, lastPlayedAt) || other.lastPlayedAt == lastPlayedAt)&&(identical(other.playbackSpeed, playbackSpeed) || other.playbackSpeed == playbackSpeed)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.statusOverride, statusOverride) || other.statusOverride == statusOverride)&&(identical(other.seriesPosition, seriesPosition) || other.seriesPosition == seriesPosition)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other.tracks, tracks)&&const DeepCollectionEquality().equals(other.chapters, chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,filePath,durationMs,addedAt,metadataId,author,series,narrator,year,folder,artworkPath,artworkScanned,positionMs,lastPlayedAt,playbackSpeed,isFavorite,statusOverride,seriesPosition,completedAt,const DeepCollectionEquality().hash(tracks),const DeepCollectionEquality().hash(chapters)]);

@override
String toString() {
  return 'Audiobook(id: $id, title: $title, filePath: $filePath, durationMs: $durationMs, addedAt: $addedAt, metadataId: $metadataId, author: $author, series: $series, narrator: $narrator, year: $year, folder: $folder, artworkPath: $artworkPath, artworkScanned: $artworkScanned, positionMs: $positionMs, lastPlayedAt: $lastPlayedAt, playbackSpeed: $playbackSpeed, isFavorite: $isFavorite, statusOverride: $statusOverride, seriesPosition: $seriesPosition, completedAt: $completedAt, tracks: $tracks, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $AudiobookCopyWith<$Res>  {
  factory $AudiobookCopyWith(Audiobook value, $Res Function(Audiobook) _then) = _$AudiobookCopyWithImpl;
@useResult
$Res call({
 String id, String title, String filePath, int durationMs, DateTime addedAt, String metadataId, String author, String series, String narrator, int? year, String folder, String? artworkPath, bool artworkScanned, int positionMs, DateTime? lastPlayedAt, double playbackSpeed, bool isFavorite, ListeningStatus? statusOverride, double? seriesPosition, DateTime? completedAt, List<AudioTrack> tracks, List<AudioChapter> chapters
});




}
/// @nodoc
class _$AudiobookCopyWithImpl<$Res>
    implements $AudiobookCopyWith<$Res> {
  _$AudiobookCopyWithImpl(this._self, this._then);

  final Audiobook _self;
  final $Res Function(Audiobook) _then;

/// Create a copy of Audiobook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? filePath = null,Object? durationMs = null,Object? addedAt = null,Object? metadataId = null,Object? author = null,Object? series = null,Object? narrator = null,Object? year = freezed,Object? folder = null,Object? artworkPath = freezed,Object? artworkScanned = null,Object? positionMs = null,Object? lastPlayedAt = freezed,Object? playbackSpeed = null,Object? isFavorite = null,Object? statusOverride = freezed,Object? seriesPosition = freezed,Object? completedAt = freezed,Object? tracks = null,Object? chapters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadataId: null == metadataId ? _self.metadataId : metadataId // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,narrator: null == narrator ? _self.narrator : narrator // ignore: cast_nullable_to_non_nullable
as String,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as String,artworkPath: freezed == artworkPath ? _self.artworkPath : artworkPath // ignore: cast_nullable_to_non_nullable
as String?,artworkScanned: null == artworkScanned ? _self.artworkScanned : artworkScanned // ignore: cast_nullable_to_non_nullable
as bool,positionMs: null == positionMs ? _self.positionMs : positionMs // ignore: cast_nullable_to_non_nullable
as int,lastPlayedAt: freezed == lastPlayedAt ? _self.lastPlayedAt : lastPlayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,playbackSpeed: null == playbackSpeed ? _self.playbackSpeed : playbackSpeed // ignore: cast_nullable_to_non_nullable
as double,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,statusOverride: freezed == statusOverride ? _self.statusOverride : statusOverride // ignore: cast_nullable_to_non_nullable
as ListeningStatus?,seriesPosition: freezed == seriesPosition ? _self.seriesPosition : seriesPosition // ignore: cast_nullable_to_non_nullable
as double?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tracks: null == tracks ? _self.tracks : tracks // ignore: cast_nullable_to_non_nullable
as List<AudioTrack>,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<AudioChapter>,
  ));
}

}


/// Adds pattern-matching-related methods to [Audiobook].
extension AudiobookPatterns on Audiobook {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Audiobook value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Audiobook() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Audiobook value)  $default,){
final _that = this;
switch (_that) {
case _Audiobook():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Audiobook value)?  $default,){
final _that = this;
switch (_that) {
case _Audiobook() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String filePath,  int durationMs,  DateTime addedAt,  String metadataId,  String author,  String series,  String narrator,  int? year,  String folder,  String? artworkPath,  bool artworkScanned,  int positionMs,  DateTime? lastPlayedAt,  double playbackSpeed,  bool isFavorite,  ListeningStatus? statusOverride,  double? seriesPosition,  DateTime? completedAt,  List<AudioTrack> tracks,  List<AudioChapter> chapters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Audiobook() when $default != null:
return $default(_that.id,_that.title,_that.filePath,_that.durationMs,_that.addedAt,_that.metadataId,_that.author,_that.series,_that.narrator,_that.year,_that.folder,_that.artworkPath,_that.artworkScanned,_that.positionMs,_that.lastPlayedAt,_that.playbackSpeed,_that.isFavorite,_that.statusOverride,_that.seriesPosition,_that.completedAt,_that.tracks,_that.chapters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String filePath,  int durationMs,  DateTime addedAt,  String metadataId,  String author,  String series,  String narrator,  int? year,  String folder,  String? artworkPath,  bool artworkScanned,  int positionMs,  DateTime? lastPlayedAt,  double playbackSpeed,  bool isFavorite,  ListeningStatus? statusOverride,  double? seriesPosition,  DateTime? completedAt,  List<AudioTrack> tracks,  List<AudioChapter> chapters)  $default,) {final _that = this;
switch (_that) {
case _Audiobook():
return $default(_that.id,_that.title,_that.filePath,_that.durationMs,_that.addedAt,_that.metadataId,_that.author,_that.series,_that.narrator,_that.year,_that.folder,_that.artworkPath,_that.artworkScanned,_that.positionMs,_that.lastPlayedAt,_that.playbackSpeed,_that.isFavorite,_that.statusOverride,_that.seriesPosition,_that.completedAt,_that.tracks,_that.chapters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String filePath,  int durationMs,  DateTime addedAt,  String metadataId,  String author,  String series,  String narrator,  int? year,  String folder,  String? artworkPath,  bool artworkScanned,  int positionMs,  DateTime? lastPlayedAt,  double playbackSpeed,  bool isFavorite,  ListeningStatus? statusOverride,  double? seriesPosition,  DateTime? completedAt,  List<AudioTrack> tracks,  List<AudioChapter> chapters)?  $default,) {final _that = this;
switch (_that) {
case _Audiobook() when $default != null:
return $default(_that.id,_that.title,_that.filePath,_that.durationMs,_that.addedAt,_that.metadataId,_that.author,_that.series,_that.narrator,_that.year,_that.folder,_that.artworkPath,_that.artworkScanned,_that.positionMs,_that.lastPlayedAt,_that.playbackSpeed,_that.isFavorite,_that.statusOverride,_that.seriesPosition,_that.completedAt,_that.tracks,_that.chapters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Audiobook implements Audiobook {
  const _Audiobook({required this.id, required this.title, required this.filePath, required this.durationMs, required this.addedAt, this.metadataId = '', this.author = '', this.series = '', this.narrator = '', this.year, this.folder = 'Imported', this.artworkPath, this.artworkScanned = false, this.positionMs = 0, this.lastPlayedAt, this.playbackSpeed = 1.0, this.isFavorite = false, this.statusOverride, this.seriesPosition, this.completedAt, final  List<AudioTrack> tracks = const <AudioTrack>[], final  List<AudioChapter> chapters = const <AudioChapter>[]}): _tracks = tracks,_chapters = chapters;
  factory _Audiobook.fromJson(Map<String, dynamic> json) => _$AudiobookFromJson(json);

@override final  String id;
@override final  String title;
@override final  String filePath;
@override final  int durationMs;
@override final  DateTime addedAt;
@override@JsonKey() final  String metadataId;
@override@JsonKey() final  String author;
@override@JsonKey() final  String series;
@override@JsonKey() final  String narrator;
@override final  int? year;
@override@JsonKey() final  String folder;
@override final  String? artworkPath;
@override@JsonKey() final  bool artworkScanned;
@override@JsonKey() final  int positionMs;
@override final  DateTime? lastPlayedAt;
@override@JsonKey() final  double playbackSpeed;
@override@JsonKey() final  bool isFavorite;
@override final  ListeningStatus? statusOverride;
@override final  double? seriesPosition;
@override final  DateTime? completedAt;
 final  List<AudioTrack> _tracks;
@override@JsonKey() List<AudioTrack> get tracks {
  if (_tracks is EqualUnmodifiableListView) return _tracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tracks);
}

 final  List<AudioChapter> _chapters;
@override@JsonKey() List<AudioChapter> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}


/// Create a copy of Audiobook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudiobookCopyWith<_Audiobook> get copyWith => __$AudiobookCopyWithImpl<_Audiobook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudiobookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Audiobook&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt)&&(identical(other.metadataId, metadataId) || other.metadataId == metadataId)&&(identical(other.author, author) || other.author == author)&&(identical(other.series, series) || other.series == series)&&(identical(other.narrator, narrator) || other.narrator == narrator)&&(identical(other.year, year) || other.year == year)&&(identical(other.folder, folder) || other.folder == folder)&&(identical(other.artworkPath, artworkPath) || other.artworkPath == artworkPath)&&(identical(other.artworkScanned, artworkScanned) || other.artworkScanned == artworkScanned)&&(identical(other.positionMs, positionMs) || other.positionMs == positionMs)&&(identical(other.lastPlayedAt, lastPlayedAt) || other.lastPlayedAt == lastPlayedAt)&&(identical(other.playbackSpeed, playbackSpeed) || other.playbackSpeed == playbackSpeed)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.statusOverride, statusOverride) || other.statusOverride == statusOverride)&&(identical(other.seriesPosition, seriesPosition) || other.seriesPosition == seriesPosition)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other._tracks, _tracks)&&const DeepCollectionEquality().equals(other._chapters, _chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,filePath,durationMs,addedAt,metadataId,author,series,narrator,year,folder,artworkPath,artworkScanned,positionMs,lastPlayedAt,playbackSpeed,isFavorite,statusOverride,seriesPosition,completedAt,const DeepCollectionEquality().hash(_tracks),const DeepCollectionEquality().hash(_chapters)]);

@override
String toString() {
  return 'Audiobook(id: $id, title: $title, filePath: $filePath, durationMs: $durationMs, addedAt: $addedAt, metadataId: $metadataId, author: $author, series: $series, narrator: $narrator, year: $year, folder: $folder, artworkPath: $artworkPath, artworkScanned: $artworkScanned, positionMs: $positionMs, lastPlayedAt: $lastPlayedAt, playbackSpeed: $playbackSpeed, isFavorite: $isFavorite, statusOverride: $statusOverride, seriesPosition: $seriesPosition, completedAt: $completedAt, tracks: $tracks, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$AudiobookCopyWith<$Res> implements $AudiobookCopyWith<$Res> {
  factory _$AudiobookCopyWith(_Audiobook value, $Res Function(_Audiobook) _then) = __$AudiobookCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String filePath, int durationMs, DateTime addedAt, String metadataId, String author, String series, String narrator, int? year, String folder, String? artworkPath, bool artworkScanned, int positionMs, DateTime? lastPlayedAt, double playbackSpeed, bool isFavorite, ListeningStatus? statusOverride, double? seriesPosition, DateTime? completedAt, List<AudioTrack> tracks, List<AudioChapter> chapters
});




}
/// @nodoc
class __$AudiobookCopyWithImpl<$Res>
    implements _$AudiobookCopyWith<$Res> {
  __$AudiobookCopyWithImpl(this._self, this._then);

  final _Audiobook _self;
  final $Res Function(_Audiobook) _then;

/// Create a copy of Audiobook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? filePath = null,Object? durationMs = null,Object? addedAt = null,Object? metadataId = null,Object? author = null,Object? series = null,Object? narrator = null,Object? year = freezed,Object? folder = null,Object? artworkPath = freezed,Object? artworkScanned = null,Object? positionMs = null,Object? lastPlayedAt = freezed,Object? playbackSpeed = null,Object? isFavorite = null,Object? statusOverride = freezed,Object? seriesPosition = freezed,Object? completedAt = freezed,Object? tracks = null,Object? chapters = null,}) {
  return _then(_Audiobook(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadataId: null == metadataId ? _self.metadataId : metadataId // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,narrator: null == narrator ? _self.narrator : narrator // ignore: cast_nullable_to_non_nullable
as String,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as String,artworkPath: freezed == artworkPath ? _self.artworkPath : artworkPath // ignore: cast_nullable_to_non_nullable
as String?,artworkScanned: null == artworkScanned ? _self.artworkScanned : artworkScanned // ignore: cast_nullable_to_non_nullable
as bool,positionMs: null == positionMs ? _self.positionMs : positionMs // ignore: cast_nullable_to_non_nullable
as int,lastPlayedAt: freezed == lastPlayedAt ? _self.lastPlayedAt : lastPlayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,playbackSpeed: null == playbackSpeed ? _self.playbackSpeed : playbackSpeed // ignore: cast_nullable_to_non_nullable
as double,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,statusOverride: freezed == statusOverride ? _self.statusOverride : statusOverride // ignore: cast_nullable_to_non_nullable
as ListeningStatus?,seriesPosition: freezed == seriesPosition ? _self.seriesPosition : seriesPosition // ignore: cast_nullable_to_non_nullable
as double?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tracks: null == tracks ? _self._tracks : tracks // ignore: cast_nullable_to_non_nullable
as List<AudioTrack>,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<AudioChapter>,
  ));
}


}

// dart format on
