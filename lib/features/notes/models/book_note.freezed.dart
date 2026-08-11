// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookNote {

 String get id; int get positionMs; String get text; DateTime get createdAt; String get metadataId; BookNoteKind get kind; String? get title; String? get chapterTitle; int? get endPositionMs;
/// Create a copy of BookNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookNoteCopyWith<BookNote> get copyWith => _$BookNoteCopyWithImpl<BookNote>(this as BookNote, _$identity);

  /// Serializes this BookNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookNote&&(identical(other.id, id) || other.id == id)&&(identical(other.positionMs, positionMs) || other.positionMs == positionMs)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.metadataId, metadataId) || other.metadataId == metadataId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.chapterTitle, chapterTitle) || other.chapterTitle == chapterTitle)&&(identical(other.endPositionMs, endPositionMs) || other.endPositionMs == endPositionMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,positionMs,text,createdAt,metadataId,kind,title,chapterTitle,endPositionMs);

@override
String toString() {
  return 'BookNote(id: $id, positionMs: $positionMs, text: $text, createdAt: $createdAt, metadataId: $metadataId, kind: $kind, title: $title, chapterTitle: $chapterTitle, endPositionMs: $endPositionMs)';
}


}

/// @nodoc
abstract mixin class $BookNoteCopyWith<$Res>  {
  factory $BookNoteCopyWith(BookNote value, $Res Function(BookNote) _then) = _$BookNoteCopyWithImpl;
@useResult
$Res call({
 String id, int positionMs, String text, DateTime createdAt, String metadataId, BookNoteKind kind, String? title, String? chapterTitle, int? endPositionMs
});




}
/// @nodoc
class _$BookNoteCopyWithImpl<$Res>
    implements $BookNoteCopyWith<$Res> {
  _$BookNoteCopyWithImpl(this._self, this._then);

  final BookNote _self;
  final $Res Function(BookNote) _then;

/// Create a copy of BookNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? positionMs = null,Object? text = null,Object? createdAt = null,Object? metadataId = null,Object? kind = null,Object? title = freezed,Object? chapterTitle = freezed,Object? endPositionMs = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,positionMs: null == positionMs ? _self.positionMs : positionMs // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadataId: null == metadataId ? _self.metadataId : metadataId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as BookNoteKind,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,chapterTitle: freezed == chapterTitle ? _self.chapterTitle : chapterTitle // ignore: cast_nullable_to_non_nullable
as String?,endPositionMs: freezed == endPositionMs ? _self.endPositionMs : endPositionMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookNote].
extension BookNotePatterns on BookNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookNote value)  $default,){
final _that = this;
switch (_that) {
case _BookNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookNote value)?  $default,){
final _that = this;
switch (_that) {
case _BookNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int positionMs,  String text,  DateTime createdAt,  String metadataId,  BookNoteKind kind,  String? title,  String? chapterTitle,  int? endPositionMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookNote() when $default != null:
return $default(_that.id,_that.positionMs,_that.text,_that.createdAt,_that.metadataId,_that.kind,_that.title,_that.chapterTitle,_that.endPositionMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int positionMs,  String text,  DateTime createdAt,  String metadataId,  BookNoteKind kind,  String? title,  String? chapterTitle,  int? endPositionMs)  $default,) {final _that = this;
switch (_that) {
case _BookNote():
return $default(_that.id,_that.positionMs,_that.text,_that.createdAt,_that.metadataId,_that.kind,_that.title,_that.chapterTitle,_that.endPositionMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int positionMs,  String text,  DateTime createdAt,  String metadataId,  BookNoteKind kind,  String? title,  String? chapterTitle,  int? endPositionMs)?  $default,) {final _that = this;
switch (_that) {
case _BookNote() when $default != null:
return $default(_that.id,_that.positionMs,_that.text,_that.createdAt,_that.metadataId,_that.kind,_that.title,_that.chapterTitle,_that.endPositionMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookNote extends BookNote {
  const _BookNote({required this.id, required this.positionMs, required this.text, required this.createdAt, required this.metadataId, this.kind = BookNoteKind.note, this.title, this.chapterTitle, this.endPositionMs}): super._();
  factory _BookNote.fromJson(Map<String, dynamic> json) => _$BookNoteFromJson(json);

@override final  String id;
@override final  int positionMs;
@override final  String text;
@override final  DateTime createdAt;
@override final  String metadataId;
@override@JsonKey() final  BookNoteKind kind;
@override final  String? title;
@override final  String? chapterTitle;
@override final  int? endPositionMs;

/// Create a copy of BookNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookNoteCopyWith<_BookNote> get copyWith => __$BookNoteCopyWithImpl<_BookNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookNoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookNote&&(identical(other.id, id) || other.id == id)&&(identical(other.positionMs, positionMs) || other.positionMs == positionMs)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.metadataId, metadataId) || other.metadataId == metadataId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.chapterTitle, chapterTitle) || other.chapterTitle == chapterTitle)&&(identical(other.endPositionMs, endPositionMs) || other.endPositionMs == endPositionMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,positionMs,text,createdAt,metadataId,kind,title,chapterTitle,endPositionMs);

@override
String toString() {
  return 'BookNote(id: $id, positionMs: $positionMs, text: $text, createdAt: $createdAt, metadataId: $metadataId, kind: $kind, title: $title, chapterTitle: $chapterTitle, endPositionMs: $endPositionMs)';
}


}

/// @nodoc
abstract mixin class _$BookNoteCopyWith<$Res> implements $BookNoteCopyWith<$Res> {
  factory _$BookNoteCopyWith(_BookNote value, $Res Function(_BookNote) _then) = __$BookNoteCopyWithImpl;
@override @useResult
$Res call({
 String id, int positionMs, String text, DateTime createdAt, String metadataId, BookNoteKind kind, String? title, String? chapterTitle, int? endPositionMs
});




}
/// @nodoc
class __$BookNoteCopyWithImpl<$Res>
    implements _$BookNoteCopyWith<$Res> {
  __$BookNoteCopyWithImpl(this._self, this._then);

  final _BookNote _self;
  final $Res Function(_BookNote) _then;

/// Create a copy of BookNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? positionMs = null,Object? text = null,Object? createdAt = null,Object? metadataId = null,Object? kind = null,Object? title = freezed,Object? chapterTitle = freezed,Object? endPositionMs = freezed,}) {
  return _then(_BookNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,positionMs: null == positionMs ? _self.positionMs : positionMs // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadataId: null == metadataId ? _self.metadataId : metadataId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as BookNoteKind,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,chapterTitle: freezed == chapterTitle ? _self.chapterTitle : chapterTitle // ignore: cast_nullable_to_non_nullable
as String?,endPositionMs: freezed == endPositionMs ? _self.endPositionMs : endPositionMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
