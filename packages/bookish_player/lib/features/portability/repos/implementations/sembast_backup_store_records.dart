part of 'sembast_backup_store_repository.dart';

typedef _StoredRecords = List<RecordSnapshot<String, Map<String, Object?>>>;
typedef _SnapshotRecords = ({
  _StoredRecords books,
  _StoredRecords notes,
  _StoredRecords metadata,
  _StoredRecords sessions,
  Map<String, Object?>? appearance,
  Map<String, Object?>? playback,
});

extension on SembastBackupStoreRepository {
  BackupSettings _backupSettings(
    Map<String, Object?>? appearance,
    Map<String, Object?>? playback,
  ) => BackupSettings(
    theme: appearance?['theme'] as String? ?? 'system',
    useSystemColors: appearance?['useSystemColors'] as bool? ?? true,
    primaryColor:
        appearance?['primaryColor'] as int? ?? defaultBookishSeedColorValue,
    playback: playback == null
        ? const PlaybackPreferences()
        : PlaybackPreferences.fromJson(Map<String, dynamic>.from(playback)),
  );
}
