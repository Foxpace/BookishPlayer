// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiobook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Audiobook _$AudiobookFromJson(Map<String, dynamic> json) => _Audiobook(
  id: json['id'] as String,
  title: json['title'] as String,
  filePath: json['filePath'] as String,
  durationMs: (json['durationMs'] as num).toInt(),
  addedAt: DateTime.parse(json['addedAt'] as String),
  author: json['author'] as String? ?? '',
  series: json['series'] as String? ?? '',
  narrator: json['narrator'] as String? ?? '',
  year: (json['year'] as num?)?.toInt(),
  folder: json['folder'] as String? ?? 'Imported',
  artworkPath: json['artworkPath'] as String?,
  artworkScanned: json['artworkScanned'] as bool? ?? false,
  positionMs: (json['positionMs'] as num?)?.toInt() ?? 0,
  lastPlayedAt: json['lastPlayedAt'] == null
      ? null
      : DateTime.parse(json['lastPlayedAt'] as String),
  playbackSpeed: (json['playbackSpeed'] as num?)?.toDouble() ?? 1.0,
  tracks:
      (json['tracks'] as List<dynamic>?)
          ?.map((e) => AudioTrack.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AudioTrack>[],
  chapters:
      (json['chapters'] as List<dynamic>?)
          ?.map((e) => AudioChapter.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AudioChapter>[],
);

Map<String, dynamic> _$AudiobookToJson(_Audiobook instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'filePath': instance.filePath,
      'durationMs': instance.durationMs,
      'addedAt': instance.addedAt.toIso8601String(),
      'author': instance.author,
      'series': instance.series,
      'narrator': instance.narrator,
      'year': instance.year,
      'folder': instance.folder,
      'artworkPath': instance.artworkPath,
      'artworkScanned': instance.artworkScanned,
      'positionMs': instance.positionMs,
      'lastPlayedAt': instance.lastPlayedAt?.toIso8601String(),
      'playbackSpeed': instance.playbackSpeed,
      'tracks': instance.tracks.map((e) => e.toJson()).toList(),
      'chapters': instance.chapters.map((e) => e.toJson()).toList(),
    };

_AudioTrack _$AudioTrackFromJson(Map<String, dynamic> json) => _AudioTrack(
  id: json['id'] as String,
  title: json['title'] as String,
  filePath: json['filePath'] as String,
  durationMs: (json['durationMs'] as num).toInt(),
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$AudioTrackToJson(_AudioTrack instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'filePath': instance.filePath,
      'durationMs': instance.durationMs,
      'order': instance.order,
    };

_AudioChapter _$AudioChapterFromJson(Map<String, dynamic> json) =>
    _AudioChapter(
      title: json['title'] as String,
      startMs: (json['startMs'] as num).toInt(),
    );

Map<String, dynamic> _$AudioChapterToJson(_AudioChapter instance) =>
    <String, dynamic>{'title': instance.title, 'startMs': instance.startMs};
