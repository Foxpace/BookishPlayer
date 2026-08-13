import 'package:bookish_player/features/importing/use_cases/audiobook_import_workflow.dart';
import 'package:bookish_player/features/importing/use_cases/import_cleanup.dart';
import 'package:bookish_player/features/importing/use_cases/import_source_gateway.dart';
import 'package:bookish_player/features/importing/use_cases/imported_book_saver.dart';
import 'package:bookish_player/features/importing/use_cases/importing_use_cases.dart';
import 'package:bookish_player/features/importing/repos/audiobook_metadata_extractor.dart';
import 'package:bookish_player/features/importing/repos/import_repositories.dart';
import 'package:bookish_player/features/importing/cubits/import_cubit.dart';
import 'package:bookish_player/features/importing/cubits/import_cubits.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fakes/fake_clock.dart';
import '../../support/fakes/fake_app_diagnostics.dart';
import '../../support/fakes/fake_id_generator.dart';
import 'import_test_support.dart';

void main() {
  group('Import cubit', () {
    late ImportCubit sut;

    tearDown(() => sut.close());

    test(
      'Given the import cubit, When its behavior is exercised, Then cancelled Android picker remains visible and can be retried',
      () async {
        // GIVEN
        final files = FakeImportFiles(const []);
        sut = _cubit(files);

        // WHEN
        await sut.start();

        // THEN
        expect(sut.state.status, ImportStatus.cancelled);
        expect(sut.state.heading, ImportHeading.noFilesSelected);
        expect(files.pickCount, 1);

        await sut.retry();
        expect(files.pickCount, 2);
      },
    );

    test(
      'Given the import cubit, When its behavior is exercised, Then normal import clears picker cache after the copied book is saved',
      () async {
        // GIVEN
        final events = <String>[];
        final files = FakeImportFiles(const [
          SelectedAudioFile(
            sourcePath: '/picker-cache/book.m4b',
            displayName: 'book.m4b',
            sizeBytes: 100,
          ),
        ], events: events);
        sut = _cubit(files, events: events);
        await sut.start();
        // WHEN
        await Future<void>.delayed(Duration.zero);

        // THEN
        expect(sut.state.status, ImportStatus.complete);
        expect(events, ['copy', 'save', 'clear-cache']);
      },
    );

    test(
      'Given the import cubit, When its behavior is exercised, Then unrelated selected files are imported as separate books',
      () async {
        // GIVEN
        final books = FakeImportBooks(<String>[]);
        final files = FakeImportFiles(const [
          SelectedAudioFile(
            sourcePath: '/picker-cache/first.m4b',
            displayName: 'First Book.m4b',
          ),
          SelectedAudioFile(
            sourcePath: '/picker-cache/second.m4b',
            displayName: 'Second Book.m4b',
          ),
        ]);
        sut = _cubit(files, books: books);

        // WHEN
        await sut.start();

        // THEN
        expect(sut.state.status, ImportStatus.complete);
        expect(sut.state.importedCount, 2);
        expect(books.saved.map((book) => book.title), [
          'First Book',
          'Second Book',
        ]);
      },
    );

    test(
      'Given the import cubit, When its behavior is exercised, Then numbered files are also imported as separate books',
      () async {
        // GIVEN
        final books = FakeImportBooks(<String>[]);
        final files = FakeImportFiles(const [
          SelectedAudioFile(
            sourcePath: '/picker-cache/book-01.mp3',
            displayName: 'Book Part 01.mp3',
          ),
          SelectedAudioFile(
            sourcePath: '/picker-cache/book-02.mp3',
            displayName: 'Book Part 02.mp3',
          ),
        ]);
        sut = _cubit(files, books: books);

        // WHEN
        await sut.start();

        // THEN
        expect(sut.state.status, ImportStatus.complete);
        expect(books.saved, hasLength(2));
        expect(books.saved.map((book) => book.title), [
          'Book Part 01',
          'Book Part 02',
        ]);
        expect(books.saved.every((book) => book.tracks.isEmpty), isTrue);
      },
    );

    test(
      'Given the import cubit, When its behavior is exercised, Then embedded metadata is applied conservatively during import',
      () async {
        // GIVEN
        final books = FakeImportBooks(<String>[]);
        final files = FakeImportFiles(const [
          SelectedAudioFile(
            sourcePath: '/picker-cache/fallback-name.m4b',
            displayName: 'fallback-name.m4b',
          ),
        ]);
        sut = _cubit(
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

        await sut.start();

        // WHEN
        final book = books.saved.single;
        // THEN
        expect(book.title, 'Embedded Title');
        expect(book.author, 'Ursula K. Le Guin');
        expect(book.series, 'Earthsea');
        expect(book.narrator, 'Rob Inglis');
        expect(book.year, 1968);
      },
    );
  });
}

ImportCubit _cubit(
  FakeImportFiles files, {
  List<String>? events,
  FakeImportBooks? books,
  ImportedAudiobookMetadata metadata = const ImportedAudiobookMetadata(),
}) {
  final repository = books ?? FakeImportBooks(events ?? <String>[]);
  final clock = FakeClock();
  final workflow = AudiobookImportWorkflow(
    ImportSourceGateway(
      files,
      FakeImportMediaProbe(),
      FakeImportChapters(),
      FakeImportArtwork(),
      FakeImportMetadata(metadata),
    ),
    ImportedBookSaver(repository, repository, clock, FakeIdGenerator()),
    clock,
    ImportCleanup(files, FakeAppDiagnostics()),
  );
  return ImportCubit(
    ImportUseCases(
      importBook: ImportBookUseCase(workflow),
      removeTransferredSources: RemoveTransferredSourcesUseCase(workflow),
      copyDiagnostics: CopyImportDiagnosticsUseCase(FakeImportDiagnostics()),
    ),
  );
}
