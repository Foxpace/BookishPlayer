// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookNote _$BookNoteFromJson(Map<String, dynamic> json) => _BookNote(
  id: json['id'] as String,
  bookId: json['bookId'] as String,
  positionMs: (json['positionMs'] as num).toInt(),
  text: json['text'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  chapterTitle: json['chapterTitle'] as String?,
  endPositionMs: (json['endPositionMs'] as num?)?.toInt(),
);

Map<String, dynamic> _$BookNoteToJson(_BookNote instance) => <String, dynamic>{
  'id': instance.id,
  'bookId': instance.bookId,
  'positionMs': instance.positionMs,
  'text': instance.text,
  'createdAt': instance.createdAt.toIso8601String(),
  'chapterTitle': instance.chapterTitle,
  'endPositionMs': instance.endPositionMs,
};
