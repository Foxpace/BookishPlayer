import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/listening_session.dart';
import '../../player/domain/book_note.dart';
import '../../settings/domain/playback_preferences.dart';

part 'bookish_backup.freezed.dart';
part 'bookish_backup.g.dart';

@freezed
abstract class BackupSettings with _$BackupSettings {
  const factory BackupSettings({
    required String theme,
    @Default(PlaybackPreferences()) PlaybackPreferences playback,
  }) = _BackupSettings;

  factory BackupSettings.fromJson(Map<String, dynamic> json) =>
      _$BackupSettingsFromJson(json);
}

@freezed
abstract class BookishBackup with _$BookishBackup {
  const factory BookishBackup({
    required DateTime exportedAt,
    required BackupSettings settings,
    @Default(1) int schemaVersion,
    @Default(<Audiobook>[]) List<Audiobook> books,
    @Default(<BookNote>[]) List<BookNote> notes,
    @Default(<ListeningSession>[]) List<ListeningSession> sessions,
  }) = _BookishBackup;

  factory BookishBackup.fromJson(Map<String, dynamic> json) =>
      _$BookishBackupFromJson(json);
}
