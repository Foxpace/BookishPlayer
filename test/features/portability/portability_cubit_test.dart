import 'dart:convert';

import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/library/domain/audiobook_repository.dart';
import 'package:bookish_player/features/player/domain/book_note.dart';
import 'package:bookish_player/features/portability/domain/local_export_repository.dart';
import 'package:bookish_player/features/portability/presentation/portability_cubit.dart';
import 'package:bookish_player/features/portability/presentation/portability_state.dart';
import 'package:bookish_player/features/settings/domain/settings_repository.dart';
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
    final books = _Books([original], [note]);
    final settings = _Settings(ThemePreference.dark);
    final files = _Exports();
    final cubit = PortabilityCubit(books, settings, files);

    await cubit.backup();

    expect(cubit.state.status, PortabilityStatus.success);
    expect(files.backup, isNotNull);
    books
      ..books = const []
      ..notes = const [];
    settings.preference = ThemePreference.system;

    await cubit.restore();

    expect(cubit.state.status, PortabilityStatus.success);
    expect(books.books, [original]);
    expect(books.books.single.author, 'Ursula K. Le Guin');
    expect(books.books.single.series, 'Hainish Cycle');
    expect(books.books.single.narrator, 'George Guidall');
    expect(books.books.single.year, 1969);
    expect(books.notes, [note]);
    expect(settings.preference, ThemePreference.dark);
    await cubit.close();
  });
}

class _Exports implements LocalExportRepository {
  Map<String, dynamic>? backup;

  @override
  Future<bool> exportBackup(Map<String, dynamic> backup) async {
    this.backup = Map<String, dynamic>.from(
      jsonDecode(jsonEncode(backup)) as Map,
    );
    return true;
  }

  @override
  Future<Map<String, dynamic>?> pickBackup() async => backup;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Books implements AudiobookRepository {
  _Books(this.books, this.notes);

  List<Audiobook> books;
  List<BookNote> notes;

  @override
  Future<List<Audiobook>> getBooks() async => books;

  @override
  Future<List<BookNote>> getAllNotes() async => notes;

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
  _Settings(this.preference);

  ThemePreference preference;

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
}
