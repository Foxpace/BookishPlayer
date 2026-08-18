import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/models/library_models.dart';
import '../../library/models/listening_session.dart';
import '../../notes/models/book_note.dart';
import '../../settings/models/playback_preferences.dart';

part 'bookish_backup.freezed.dart';
part 'bookish_backup.g.dart';
part 'backup_settings.dart';

@freezed
abstract class BookishBackup with _$BookishBackup {
  const factory BookishBackup({
    required DateTime exportedAt,
    required BackupSettings settings,
    @Default(3) int schemaVersion,
    @Default(<Audiobook>[]) List<Audiobook> books,
    @Default(<BookNote>[]) List<BookNote> notes,
    @Default(<BookMetadata>[]) List<BookMetadata> bookMetadata,
    @Default(<ListeningSession>[]) List<ListeningSession> sessions,
  }) = _BookishBackup;

  factory BookishBackup.fromJson(Map<String, dynamic> json) =>
      _$BookishBackupFromJson(json);
}
