// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookMetadata _$BookMetadataFromJson(Map<String, dynamic> json) =>
    _BookMetadata(
      id: json['id'] as String,
      fingerprint: json['fingerprint'] as String,
      title: json['title'] as String,
      durationMs: (json['durationMs'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      activeBookId: json['activeBookId'] as String?,
      author: json['author'] as String? ?? '',
      series: json['series'] as String? ?? '',
      narrator: json['narrator'] as String? ?? '',
      year: (json['year'] as num?)?.toInt(),
      folder: json['folder'] as String? ?? 'Imported',
      seriesPosition: (json['seriesPosition'] as num?)?.toDouble(),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      artworkPath: json['artworkPath'] as String?,
      artworkScanned: json['artworkScanned'] as bool? ?? false,
      chapters:
          (json['chapters'] as List<dynamic>?)
              ?.map((e) => AudioChapter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AudioChapter>[],
    );

Map<String, dynamic> _$BookMetadataToJson(_BookMetadata instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fingerprint': instance.fingerprint,
      'title': instance.title,
      'durationMs': instance.durationMs,
      'createdAt': instance.createdAt.toIso8601String(),
      'activeBookId': instance.activeBookId,
      'author': instance.author,
      'series': instance.series,
      'narrator': instance.narrator,
      'year': instance.year,
      'folder': instance.folder,
      'seriesPosition': instance.seriesPosition,
      'completedAt': instance.completedAt?.toIso8601String(),
      'artworkPath': instance.artworkPath,
      'artworkScanned': instance.artworkScanned,
      'chapters': instance.chapters.map((e) => e.toJson()).toList(),
    };
