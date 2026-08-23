part of 'bookish_backup.dart';

@freezed
abstract class BackupSettings with _$BackupSettings {
  const factory BackupSettings({
    required String theme,
    @Default(true) bool useSystemColors,
    @Default(defaultBookishSeedColorValue) int primaryColor,
    @Default(PlaybackPreferences()) PlaybackPreferences playback,
  }) = _BackupSettings;

  factory BackupSettings.fromJson(Map<String, dynamic> json) =>
      _$BackupSettingsFromJson(json);
}
