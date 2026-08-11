// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AudioChapter _$AudioChapterFromJson(Map<String, dynamic> json) =>
    _AudioChapter(
      title: json['title'] as String,
      startMs: (json['startMs'] as num).toInt(),
    );

Map<String, dynamic> _$AudioChapterToJson(_AudioChapter instance) =>
    <String, dynamic>{'title': instance.title, 'startMs': instance.startMs};
