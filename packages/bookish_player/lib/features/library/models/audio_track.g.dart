// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
