// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookish_backup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookishBackup _$BookishBackupFromJson(Map<String, dynamic> json) =>
    _BookishBackup(
      exportedAt: DateTime.parse(json['exportedAt'] as String),
      settings: BackupSettings.fromJson(
        json['settings'] as Map<String, dynamic>,
      ),
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 3,
      books:
          (json['books'] as List<dynamic>?)
              ?.map((e) => Audiobook.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Audiobook>[],
      notes:
          (json['notes'] as List<dynamic>?)
              ?.map((e) => BookNote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BookNote>[],
      bookMetadata:
          (json['bookMetadata'] as List<dynamic>?)
              ?.map((e) => BookMetadata.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BookMetadata>[],
      sessions:
          (json['sessions'] as List<dynamic>?)
              ?.map((e) => ListeningSession.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ListeningSession>[],
    );

Map<String, dynamic> _$BookishBackupToJson(_BookishBackup instance) =>
    <String, dynamic>{
      'exportedAt': instance.exportedAt.toIso8601String(),
      'settings': instance.settings.toJson(),
      'schemaVersion': instance.schemaVersion,
      'books': instance.books.map((e) => e.toJson()).toList(),
      'notes': instance.notes.map((e) => e.toJson()).toList(),
      'bookMetadata': instance.bookMetadata.map((e) => e.toJson()).toList(),
      'sessions': instance.sessions.map((e) => e.toJson()).toList(),
    };

_BackupSettings _$BackupSettingsFromJson(
  Map<String, dynamic> json,
) => _BackupSettings(
  theme: json['theme'] as String,
  useSystemColors: json['useSystemColors'] as bool? ?? true,
  primaryColor:
      (json['primaryColor'] as num?)?.toInt() ?? defaultBookishSeedColorValue,
  playback: json['playback'] == null
      ? const PlaybackPreferences()
      : PlaybackPreferences.fromJson(json['playback'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BackupSettingsToJson(_BackupSettings instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'useSystemColors': instance.useSystemColors,
      'primaryColor': instance.primaryColor,
      'playback': instance.playback.toJson(),
    };
