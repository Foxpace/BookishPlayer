import 'dart:convert';

import 'package:bookish_player/features/portability/use_cases/backup_workflow.dart';
import 'package:bookish_player/features/portability/use_cases/bookish_backup_validator.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/models/listening_session.dart';
import 'package:bookish_player/features/notes/models/book_note.dart';
import 'package:bookish_player/features/portability/repos/local_export_repository.dart';
import 'package:bookish_player/features/portability/repos/backup_store_repository.dart';
import 'package:bookish_player/features/portability/models/bookish_backup.dart';
import 'package:bookish_player/features/portability/cubits/portability_cubit.dart';
import 'package:bookish_player/features/portability/cubits/portability_status.dart';
import 'package:bookish_player/features/settings/models/playback_preferences.dart';
import 'package:bookish_player/features/settings/models/theme_preference.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Complete local library backup', () {
    test(
      'Given a complete local library backup, When it is exported and restored, Then all audiobook metadata is preserved',
      () async {
        // GIVEN
        final original = Audiobook(
          id: 'book-1',
          title: 'The Left Hand of Darkness',
          filePath: '/books/left-hand.m4b',
          durationMs: 3600000,
          addedAt: DateTime.utc(2026, 1, 2),
          author: 'Ursula K. Le Guin',
          series: 'Hainish Cycle',
          narrator: 'George Guidall',
          year: 1969,
          folder: 'Science Fiction',
        );
        final note = BookNote(
          id: 'note-1',
          metadataId: original.id,
          positionMs: 42000,
          text: 'A note',
          createdAt: DateTime.utc(2026, 1, 3),
          chapterTitle: 'Chapter one',
          endPositionMs: 48000,
        );
        final session = ListeningSession(
          id: 'session-1',
          metadataId: original.id,
          startedAt: DateTime.utc(2026, 1, 4),
          endedAt: DateTime.utc(2026, 1, 4, 0, 20),
          listenedMs: 1200000,
          startPositionMs: 0,
          endPositionMs: 1200000,
          speed: 1.25,
        );
        final metadata = metadataForBook(original);
        final books = _Books([original], [note], [session], [metadata]);
        final settings = _Settings(
          ThemePreference.dark,
          const PlaybackPreferences(rewindSeconds: 30, voiceBoost: true),
        );
        final files = _Exports();
        final workflow = BackupWorkflow(
          _Store(books, settings),
          files,
          const BookishBackupValidator(),
        );
        final sut = PortabilityCubit(workflow);

        // WHEN
        await sut.backup();

        // THEN
        expect(sut.state.status, PortabilityStatus.success);
        expect(files.backup, isNotNull);
        books
          ..books = const []
          ..notes = const []
          ..sessions = const []
          ..metadata = const [];
        settings.preference = ThemePreference.system;
        settings.playback = const PlaybackPreferences();

        await sut.restore();

        expect(sut.state.status, PortabilityStatus.success);
        expect(books.books, [original]);
        expect(books.books.single.author, 'Ursula K. Le Guin');
        expect(books.books.single.series, 'Hainish Cycle');
        expect(books.books.single.narrator, 'George Guidall');
        expect(books.books.single.year, 1969);
        expect(books.notes, [note]);
        expect(books.metadata, [metadata]);
        expect(books.sessions, [session]);
        expect(settings.preference, ThemePreference.dark);
        expect(settings.playback.rewindSeconds, 30);
        expect(settings.playback.voiceBoost, isTrue);
        await sut.close();
      },
    );
  });
}

class _Exports implements LocalExportRepository {
  BookishBackup? backup;

  @override
  Future<bool> exportNotes(Audiobook book, List<BookNote> notes) async => false;

  @override
  Future<bool> exportBackup(BookishBackup backup) async {
    this.backup = BookishBackup.fromJson(
      Map<String, dynamic>.from(jsonDecode(jsonEncode(backup)) as Map),
    );
    return true;
  }

  @override
  Future<BookishBackup?> pickBackup() async => backup;
}

class _Store implements BackupStoreRepository {
  _Store(this.books, this.settings);

  final _Books books;
  final _Settings settings;

  @override
  Future<BookishBackup> snapshot() async => BookishBackup(
    exportedAt: DateTime.utc(2026),
    books: books.books,
    notes: books.notes,
    bookMetadata: books.metadata,
    sessions: books.sessions,
    settings: BackupSettings(
      theme: settings.preference.name,
      playback: settings.playback,
    ),
  );

  @override
  Future<void> restore(BookishBackup backup) async {
    books
      ..books = backup.books
      ..notes = backup.notes
      ..sessions = backup.sessions
      ..metadata = backup.bookMetadata;
    settings
      ..preference = ThemePreference.fromStorage(backup.settings.theme)
      ..playback = backup.settings.playback;
  }
}

class _Books {
  _Books(this.books, this.notes, this.sessions, this.metadata);

  List<Audiobook> books;
  List<BookNote> notes;
  List<ListeningSession> sessions;
  List<BookMetadata> metadata;
}

class _Settings {
  _Settings(this.preference, this.playback);

  ThemePreference preference;
  PlaybackPreferences playback;
}
