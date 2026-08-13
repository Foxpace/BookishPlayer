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
  metadataId: json['metadataId'] as String? ?? '',
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
  isFavorite: json['isFavorite'] as bool? ?? false,
  statusOverride: $enumDecodeNullable(
    _$ListeningStatusEnumMap,
    json['statusOverride'],
  ),
  seriesPosition: (json['seriesPosition'] as num?)?.toDouble(),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
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
      'metadataId': instance.metadataId,
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
      'isFavorite': instance.isFavorite,
      'statusOverride': _$ListeningStatusEnumMap[instance.statusOverride],
      'seriesPosition': instance.seriesPosition,
      'completedAt': instance.completedAt?.toIso8601String(),
      'tracks': instance.tracks.map((e) => e.toJson()).toList(),
      'chapters': instance.chapters.map((e) => e.toJson()).toList(),
    };

const _$ListeningStatusEnumMap = {
  ListeningStatus.wantToListen: 'wantToListen',
  ListeningStatus.notStarted: 'notStarted',
  ListeningStatus.inProgress: 'inProgress',
  ListeningStatus.finished: 'finished',
};
