import 'package:bookish_player/features/importing/domain/audiobook_artwork_extractor.dart';
import 'package:bookish_player/features/importing/domain/audiobook_metadata_extractor.dart';
import 'package:bookish_player/features/importing/domain/chapter_parse_report.dart';
import 'package:bookish_player/features/importing/domain/file_import_repository.dart';
import 'package:bookish_player/features/importing/domain/import_diagnostics_repository.dart';
import 'package:bookish_player/features/importing/domain/m4b_chapter_parser.dart';
import 'package:bookish_player/features/importing/presentation/import_cubit.dart';
import 'package:bookish_player/features/importing/presentation/import_state.dart';
import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/library/domain/audiobook_repository.dart';
import 'package:bookish_player/features/player/domain/audio_player_repository.dart';
import 'package:bookish_player/features/library/domain/book_metadata.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('cancelled Android picker remains visible and can be retried', () async {
    final files = _Files(const []);
    final cubit = _cubit(files);

    await cubit.start();

    expect(cubit.state.status, ImportStatus.cancelled);
    expect(cubit.state.heading, 'No files were selected');
    expect(files.pickCount, 1);

    await cubit.retry();
    expect(files.pickCount, 2);
    await cubit.close();
  });

  test(
    'normal import clears picker cache after the copied book is saved',
    () async {
      final events = <String>[];
      final files = _Files(const [
        SelectedAudioFile(
          sourcePath: '/picker-cache/book.m4b',
          displayName: 'book.m4b',
          sizeBytes: 100,
        ),
      ], events: events);
      final cubit = _cubit(files, events: events);
      await cubit.start();
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.status, ImportStatus.complete);
      expect(events, ['copy', 'save', 'clear-cache']);
      await cubit.close();
    },
  );

  test('unrelated selected files are imported as separate books', () async {
    final books = _Books(<String>[]);
    final files = _Files(const [
      SelectedAudioFile(
        sourcePath: '/picker-cache/first.m4b',
        displayName: 'First Book.m4b',
      ),
      SelectedAudioFile(
        sourcePath: '/picker-cache/second.m4b',
        displayName: 'Second Book.m4b',
      ),
    ]);
    final cubit = _cubit(files, books: books);

    await cubit.start();

    expect(cubit.state.status, ImportStatus.complete);
    expect(cubit.state.importedCount, 2);
    expect(books.saved.map((book) => book.title), [
      'First Book',
      'Second Book',
    ]);
    await cubit.close();
  });

  test('numbered files are also imported as separate books', () async {
    final books = _Books(<String>[]);
    final files = _Files(const [
      SelectedAudioFile(
        sourcePath: '/picker-cache/book-01.mp3',
        displayName: 'Book Part 01.mp3',
      ),
      SelectedAudioFile(
        sourcePath: '/picker-cache/book-02.mp3',
        displayName: 'Book Part 02.mp3',
      ),
    ]);
    final cubit = _cubit(files, books: books);

    await cubit.start();

    expect(cubit.state.status, ImportStatus.complete);
    expect(books.saved, hasLength(2));
    expect(books.saved.map((book) => book.title), [
      'Book Part 01',
      'Book Part 02',
    ]);
    expect(books.saved.every((book) => book.tracks.isEmpty), isTrue);
    await cubit.close();
  });

  test('embedded metadata is applied conservatively during import', () async {
    final books = _Books(<String>[]);
    final files = _Files(const [
      SelectedAudioFile(
        sourcePath: '/picker-cache/fallback-name.m4b',
        displayName: 'fallback-name.m4b',
      ),
    ]);
    final cubit = _cubit(
      files,
      books: books,
      metadata: const ImportedAudiobookMetadata(
        title: 'Embedded Title',
        author: 'Ursula K. Le Guin',
        series: 'Earthsea',
        narrator: 'Rob Inglis',
        year: 1968,
      ),
    );

    await cubit.start();

    final book = books.saved.single;
    expect(book.title, 'Embedded Title');
    expect(book.author, 'Ursula K. Le Guin');
    expect(book.series, 'Earthsea');
    expect(book.narrator, 'Rob Inglis');
    expect(book.year, 1968);
    await cubit.close();
  });
}

ImportCubit _cubit(
  _Files files, {
  List<String>? events,
  _Books? books,
  ImportedAudiobookMetadata metadata = const ImportedAudiobookMetadata(),
}) {
  final repository = books ?? _Books(events ?? <String>[]);
  return ImportCubit(
    files,
    _Audio(),
    repository,
    repository,
    _Chapters(),
    _Artwork(),
    _Metadata(metadata),
    _Diagnostics(),
  );
}

class _Files implements FileImportRepository {
  _Files(this.selected, {this.events});

  final List<SelectedAudioFile> selected;
  final List<String>? events;
  var pickCount = 0;

  @override
  Future<List<SelectedAudioFile>> pickAudioFiles() async {
    pickCount++;
    return selected;
  }

  @override
  Future<ImportedAudioFile> importFile(
    SelectedAudioFile selected, {
    FileCopyProgress? onProgress,
  }) async {
    events?.add('copy');
    onProgress?.call(100, 100);
    return const ImportedAudioFile(
      path: '/bookish/book.m4b',
      displayName: 'book.m4b',
    );
  }

  @override
  Future<void> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {
    events?.add('remove');
  }

  @override
  Future<void> clearTemporaryFiles() async {
    events?.add('clear-cache');
  }

  @override
  Future<void> deleteImportedFile(String path) async {}

  @override
  Future<List<SelectedAudioFile>> findTransferredAudioFiles() async => selected;

  @override
  Future<String?> pickAndImportCover(String bookId) async => null;
}

class _Audio implements AudioPlayerRepository {
  @override
  Future<Duration> probeDuration(String path) async =>
      const Duration(minutes: 1);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Books implements AudiobookRepository {
  _Books(this.events);

  final List<String> events;
  final saved = <Audiobook>[];

  @override
  Future<BookMetadata?> findBookMetadata(String fingerprint) async => null;

  @override
  Future<void> saveBook(Audiobook book) async {
    saved.add(book);
    events.add('save');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Chapters implements M4bChapterParser {
  @override
  Future<ChapterParseReport> analyze(String filePath) async =>
      const ChapterParseReport();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Artwork implements AudiobookArtworkExtractor {
  @override
  Future<String?> extract(String audioFilePath) async => null;
}

class _Metadata implements AudiobookMetadataExtractor {
  const _Metadata(this.metadata);

  final ImportedAudiobookMetadata metadata;

  @override
  Future<ImportedAudiobookMetadata> extract(String audioFilePath) async =>
      metadata;
}

class _Diagnostics implements ImportDiagnosticsRepository {
  @override
  Future<void> copy(String diagnostics) async {}
}
