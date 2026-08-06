// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookNote _$BookNoteFromJson(Map<String, dynamic> json) => _BookNote(
  id: json['id'] as String,
  positionMs: (json['positionMs'] as num).toInt(),
  text: json['text'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  metadataId: json['metadataId'] as String,
  kind:
      $enumDecodeNullable(_$BookNoteKindEnumMap, json['kind']) ??
      BookNoteKind.note,
  title: json['title'] as String?,
  chapterTitle: json['chapterTitle'] as String?,
  endPositionMs: (json['endPositionMs'] as num?)?.toInt(),
);

Map<String, dynamic> _$BookNoteToJson(_BookNote instance) => <String, dynamic>{
  'id': instance.id,
  'positionMs': instance.positionMs,
  'text': instance.text,
  'createdAt': instance.createdAt.toIso8601String(),
  'metadataId': instance.metadataId,
  'kind': _$BookNoteKindEnumMap[instance.kind]!,
  'title': instance.title,
  'chapterTitle': instance.chapterTitle,
  'endPositionMs': instance.endPositionMs,
};

const _$BookNoteKindEnumMap = {
  BookNoteKind.note: 'note',
  BookNoteKind.bookmark: 'bookmark',
  BookNoteKind.voice: 'voice',
};
