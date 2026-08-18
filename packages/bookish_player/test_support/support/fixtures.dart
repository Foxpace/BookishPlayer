import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/models/listening_session.dart';
import 'package:bookish_player/features/notes/models/book_note.dart';
import 'package:bookish_player/features/portability/models/bookish_backup.dart';
import 'package:bookish_player/features/settings/models/playback_preferences.dart';

final fixtureTime = DateTime.utc(2026, 1, 2, 12);

Audiobook audiobookFixture({
  String id = 'book-1',
  String metadataId = 'metadata-1',
}) => Audiobook(
  id: id,
  metadataId: metadataId,
  title: 'A Test Audiobook',
  filePath: '/fixtures/a-test-audiobook.m4b',
  durationMs: 3_600_000,
  addedAt: fixtureTime,
);

BookMetadata bookMetadataFixture({
  String id = 'metadata-1',
  String? activeBookId = 'book-1',
}) => BookMetadata(
  id: id,
  fingerprint: 'a test audiobook||3600000',
  title: 'A Test Audiobook',
  durationMs: 3_600_000,
  createdAt: fixtureTime,
  activeBookId: activeBookId,
);

BookNote bookNoteFixture({
  String id = 'note-1',
  String metadataId = 'metadata-1',
}) => BookNote(
  id: id,
  metadataId: metadataId,
  positionMs: 42_000,
  text: 'A deterministic note',
  createdAt: fixtureTime,
);

ListeningSession listeningSessionFixture({
  String id = 'session-1',
  String metadataId = 'metadata-1',
}) => ListeningSession(
  id: id,
  metadataId: metadataId,
  startedAt: fixtureTime,
  endedAt: fixtureTime.add(const Duration(minutes: 10)),
  listenedMs: 600_000,
  startPositionMs: 0,
  endPositionMs: 600_000,
  speed: 1,
);

const settingsFixture = PlaybackPreferences(
  rewindSeconds: 20,
  forwardSeconds: 30,
);

BookishBackup backupFixture({
  int schemaVersion = 3,
  String theme = 'system',
  ({
    List<Audiobook>? books,
    List<BookMetadata>? metadata,
    List<BookNote>? notes,
    List<ListeningSession>? sessions,
  })?
  content,
}) => BookishBackup(
  exportedAt: fixtureTime,
  schemaVersion: schemaVersion,
  settings: BackupSettings(theme: theme, playback: settingsFixture),
  books: content?.books ?? [audiobookFixture()],
  bookMetadata: content?.metadata ?? [bookMetadataFixture()],
  notes: content?.notes ?? [bookNoteFixture()],
  sessions: content?.sessions ?? [listeningSessionFixture()],
);
