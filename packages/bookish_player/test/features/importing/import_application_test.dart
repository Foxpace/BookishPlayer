import 'dart:async';

import 'package:bookish_player/features/importing/models/import_models.dart';
import 'package:bookish_player/features/importing/repos/audiobook_metadata_extractor.dart';
import 'package:bookish_player/features/importing/repos/file_import_repository.dart';
import 'package:bookish_player/features/importing/repos/selected_audio_file.dart';
import 'package:bookish_player/features/importing/use_cases/import_application.dart';
import 'package:bookish_player/features/importing/use_cases/import_cleanup.dart';
import 'package:bookish_player/features/importing/use_cases/import_source_gateway.dart';
import 'package:bookish_player/features/importing/use_cases/imported_book_saver.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/features/importing/import_test_support.dart';
import '../../../test_support/support/fakes/fake_app_diagnostics.dart';
import '../../../test_support/support/fakes/fake_clock.dart';
import '../../../test_support/support/fakes/fake_id_generator.dart';

void main() {
  group('Import application', () {
    test(
      'Given two selected audiobooks, When the second fails after copying, Then the first remains committed and copied diagnostics omit private input',
      () async {
        // GIVEN
        const rawSecret =
            'provider failed at /private/reader/second-secret.m4b';
        final files = _Files(_selectedBooks);
        final books = FakeImportBooks(<String>[]);
        final sut = _application(
          files,
          books,
          metadata: const _MetadataFailure('/bookish/import-1.m4b', rawSecret),
        );

        // WHEN
        final failure = await _captureFailure(
          sut.importBooks(finderTransfer: false, onProgress: (_) {}),
        );

        // THEN
        expect(books.saved.map((book) => book.title), ['First']);
        expect(failure.importedCount, 1);
        expect(failure.failedItem?.displayName, 'second-secret.m4b');
        expect(failure.stage, ImportStage.analyzingChapters);
        expect(files.deletedPaths, ['/bookish/import-1.m4b']);
        expect(failure.diagnostics, contains('Failure kind: unexpected'));
        expect(failure.diagnostics, isNot(contains('second-secret')));
        expect(failure.diagnostics, isNot(contains('/private/reader')));
        expect(failure.diagnostics, isNot(contains(rawSecret)));
      },
    );

    test(
      'Given one committed audiobook and a second active copy, When cancellation is requested, Then cancellation is intentional and the committed book remains',
      () async {
        // GIVEN
        final files = _Files(_selectedBooks, pauseCopyAt: 1);
        final books = FakeImportBooks(<String>[]);
        final sut = _application(files, books);
        final import = sut.importBooks(
          finderTransfer: false,
          onProgress: (_) {},
        );
        await files.copyPaused.future;

        // WHEN
        sut.cancelImport();
        final cancellation = await _captureCancellation(import);

        // THEN
        expect(cancellation.importedCount, 1);
        expect(books.saved.map((book) => book.title), ['First']);
        expect(files.clearCount, 1);
      },
    );
  });
}

const _selectedBooks = [
  SelectedAudioFile(
    sourcePath: '/private/reader/first.m4b',
    displayName: 'first.m4b',
  ),
  SelectedAudioFile(
    sourcePath: '/private/reader/second-secret.m4b',
    displayName: 'second-secret.m4b',
  ),
];

ImportApplication _application(
  _Files files,
  FakeImportBooks books, {
  AudiobookMetadataExtractor metadata = const FakeImportMetadata(
    ImportedAudiobookMetadata(),
  ),
}) {
  final clock = FakeClock();
  return ImportApplication(
    ImportSourceGateway(
      files,
      FakeImportMediaProbe(),
      FakeImportChapters(),
      FakeImportArtwork(),
      metadata,
    ),
    ImportedBookSaver(books, books, clock, FakeIdGenerator()),
    clock,
    ImportCleanup(files, FakeAppDiagnostics()),
    FakeImportDiagnostics(),
  );
}

Future<ImportWorkflowFailure> _captureFailure(
  Future<ImportResult> import,
) async {
  try {
    await import;
  } on ImportWorkflowFailure catch (failure) {
    return failure;
  }
  throw TestFailure('Expected import to fail.');
}

Future<ImportWorkflowCancellation> _captureCancellation(
  Future<ImportResult> import,
) async {
  try {
    await import;
  } on ImportWorkflowCancellation catch (cancellation) {
    return cancellation;
  }
  throw TestFailure('Expected import to be cancelled.');
}

class _MetadataFailure implements AudiobookMetadataExtractor {
  const _MetadataFailure(this.failingPath, this.message);

  final String failingPath;
  final String message;

  @override
  Future<ImportedAudiobookMetadata> extract(String audioFilePath) async {
    if (audioFilePath == failingPath) {
      throw Exception(message);
    }
    return const ImportedAudiobookMetadata();
  }
}

class _Files implements FileImportRepository {
  _Files(this.selected, {this.pauseCopyAt});

  final List<SelectedAudioFile> selected;
  final int? pauseCopyAt;
  final copyPaused = Completer<void>();
  final deletedPaths = <String>[];
  var copyCount = 0;
  var clearCount = 0;

  @override
  Future<List<SelectedAudioFile>> pickAudioFiles() async => selected;

  @override
  Future<List<SelectedAudioFile>> findTransferredAudioFiles() async => selected;

  @override
  Future<ImportedAudioFile> importFile(
    SelectedAudioFile selected, {
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  }) async {
    final current = copyCount++;
    onProgress?.call(0, selected.sizeBytes ?? 100);
    if (current == pauseCopyAt) {
      copyPaused.complete();
      await cancellation?.whenCancelled;
      throw const ImportCancelledException();
    }
    onProgress?.call(100, 100);
    return ImportedAudioFile(
      path: '/bookish/import-$current.m4b',
      displayName: selected.displayName,
    );
  }

  @override
  Future<void> clearTemporaryFiles() async => clearCount++;

  @override
  Future<void> deleteImportedFile(String path) async => deletedPaths.add(path);

  @override
  Future<void> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {}

  @override
  Future<String?> pickAndImportCover(String bookId) async => null;
}
