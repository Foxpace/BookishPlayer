import 'dart:convert';

import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/library/domain/audiobook_repository.dart';
import 'package:bookish_player/features/library/domain/listening_session.dart';
import 'package:bookish_player/features/player/domain/book_note.dart';
import 'package:bookish_player/features/portability/domain/local_export_repository.dart';
import 'package:bookish_player/features/portability/domain/backup_store_repository.dart';
import 'package:bookish_player/features/portability/domain/bookish_backup.dart';
import 'package:bookish_player/features/portability/presentation/portability_cubit.dart';
import 'package:bookish_player/features/portability/presentation/portability_state.dart';
import 'package:bookish_player/features/settings/domain/settings_repository.dart';
import 'package:bookish_player/features/settings/domain/playback_preferences.dart';
import 'package:bookish_player/features/settings/domain/theme_preference.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('backup export and import preserve all audiobook metadata', () async {
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
      bookId: original.id,
      positionMs: 42000,
      text: 'A note',
      createdAt: DateTime.utc(2026, 1, 3),
      chapterTitle: 'Chapter one',
      endPositionMs: 48000,
    );
    final session = ListeningSession(
      id: 'session-1',
      bookId: original.id,
      startedAt: DateTime.utc(2026, 1, 4),
      endedAt: DateTime.utc(2026, 1, 4, 0, 20),
      listenedMs: 1200000,
      startPositionMs: 0,
      endPositionMs: 1200000,
      speed: 1.25,
    );
    final books = _Books([original], [note], [session]);
    final settings = _Settings(
      ThemePreference.dark,
      const PlaybackPreferences(rewindSeconds: 30, voiceBoost: true),
    );
    final files = _Exports();
    final cubit = PortabilityCubit(_Store(books, settings), files);

    await cubit.backup();

    expect(cubit.state.status, PortabilityStatus.success);
    expect(files.backup, isNotNull);
    books
      ..books = const []
      ..notes = const []
      ..sessions = const [];
    settings.preference = ThemePreference.system;
    settings.playback = const PlaybackPreferences();

    await cubit.restore();

    expect(cubit.state.status, PortabilityStatus.success);
    expect(books.books, [original]);
    expect(books.books.single.author, 'Ursula K. Le Guin');
    expect(books.books.single.series, 'Hainish Cycle');
    expect(books.books.single.narrator, 'George Guidall');
    expect(books.books.single.year, 1969);
    expect(books.notes, [note]);
    expect(books.sessions, [session]);
    expect(settings.preference, ThemePreference.dark);
    expect(settings.playback.rewindSeconds, 30);
    expect(settings.playback.voiceBoost, isTrue);
    await cubit.close();
  });
}

class _Exports implements LocalExportRepository {
  BookishBackup? backup;

  @override
  Future<bool> exportBackup(BookishBackup backup) async {
    this.backup = BookishBackup.fromJson(
      Map<String, dynamic>.from(jsonDecode(jsonEncode(backup)) as Map),
    );
    return true;
  }

  @override
  Future<BookishBackup?> pickBackup() async => backup;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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
      ..sessions = backup.sessions;
    settings
      ..preference = ThemePreference.fromStorage(backup.settings.theme)
      ..playback = backup.settings.playback;
  }
}

class _Books implements AudiobookRepository {
  _Books(this.books, this.notes, this.sessions);

  List<Audiobook> books;
  List<BookNote> notes;
  List<ListeningSession> sessions;

  @override
  Future<List<Audiobook>> getBooks() async => books;

  @override
  Future<List<BookNote>> getAllNotes() async => notes;

  @override
  Future<List<ListeningSession>> getListeningSessions() async => sessions;

  @override
  Future<void> replaceListeningSessions(List<ListeningSession> sessions) async {
    this.sessions = sessions;
  }

  @override
  Future<void> replaceLibrary(
    List<Audiobook> books,
    List<BookNote> notes,
  ) async {
    this.books = books;
    this.notes = notes;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Settings implements SettingsRepository {
  _Settings(this.preference, this.playback);

  ThemePreference preference;
  PlaybackPreferences playback;

  @override
  Future<ThemePreference> getThemePreference() async => preference;

  @override
  Future<void> setThemePreference(ThemePreference preference) async {
    this.preference = preference;
  }

  @override
  Future<String?> getLibraryLayout() async => null;

  @override
  Future<void> setLibraryLayout(String layout) async {}

  @override
  Future<String?> getSpeechModel() async => null;

  @override
  Future<void> setSpeechModel(String model) async {}

  @override
  Future<PlaybackPreferences> getPlaybackPreferences() async => playback;

  @override
  Future<void> setPlaybackPreferences(PlaybackPreferences preferences) async {
    playback = preferences;
  }
}
