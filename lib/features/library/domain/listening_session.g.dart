// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListeningSession _$ListeningSessionFromJson(Map<String, dynamic> json) =>
    _ListeningSession(
      id: json['id'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: DateTime.parse(json['endedAt'] as String),
      listenedMs: (json['listenedMs'] as num).toInt(),
      startPositionMs: (json['startPositionMs'] as num).toInt(),
      endPositionMs: (json['endPositionMs'] as num).toInt(),
      speed: (json['speed'] as num).toDouble(),
      metadataId: json['metadataId'] as String,
    );

Map<String, dynamic> _$ListeningSessionToJson(_ListeningSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt.toIso8601String(),
      'listenedMs': instance.listenedMs,
      'startPositionMs': instance.startPositionMs,
      'endPositionMs': instance.endPositionMs,
      'speed': instance.speed,
      'metadataId': instance.metadataId,
    };
