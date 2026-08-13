import 'package:bookish_player/features/importing/use_cases/import_cleanup.dart';
import 'package:bookish_player/features/importing/models/import_runtime_state.dart';
import 'package:bookish_player/features/importing/models/import_models.dart';
import 'package:bookish_player/features/importing/repos/import_repositories.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fakes/fake_app_diagnostics.dart';
import '../../support/fakes/fake_clock.dart';

void main() {
  group('Deterministic import progress tracking', () {
    test(
      'Given deterministic import progress tracking, When stages advance before transferred-source removal fails, Then diagnostic history and retry classification are preserved',
      () {
        // GIVEN
        final clock = FakeClock();
        final sut = ImportRuntimeState(clock);
        final emitted = <ImportProgress>[];
        const selected = SelectedAudioFile(
          sourcePath: '/source/book.m4b',
          displayName: 'book.m4b',
        );

        sut.trackProgress(
          emitted.add,
          const ImportProgress(stage: ImportStage.selectingFiles),
        );
        clock.advance(const Duration(milliseconds: 25));
        sut.trackProgress(
          emitted.add,
          const ImportProgress(
            stage: ImportStage.copyingFile,
            selected: selected,
          ),
        );
        sut.recordParserDiagnostics(['chapter atom recovered']);
        clock.advance(const Duration(milliseconds: 75));

        // WHEN
        final failure = sut.buildFailure(
          const SourceRemovalException('provider rejected delete'),
          StackTrace.current,
        );

        // THEN
        expect(emitted, hasLength(2));
        expect(failure.stage, ImportStage.copyingFile);
        expect(failure.activeFile, 'book.m4b');
        expect(failure.parserDiagnostics, ['chapter atom recovered']);
        expect(failure.originalRemovalOnly, isTrue);
        expect(failure.stageHistory, [
          'selectingFiles: 25 ms',
          'copyingFile before failure: 75 ms',
        ]);

        final freshRuntime = ImportRuntimeState(clock);
        final resetFailure = freshRuntime.buildFailure(
          Exception('selection failed'),
          StackTrace.current,
        );
        expect(freshRuntime.pendingPaths, isEmpty);
        expect(resetFailure.stageHistory, isEmpty);
        expect(resetFailure.originalRemovalOnly, isFalse);
      },
    );
  });

  group('Pending import files and local diagnostics', () {
    test(
      'Given pending import files and local diagnostics, When cleanup operations partially fail, Then all paths are attempted and structured failures are recorded',
      () async {
        // GIVEN
        final files = _Files()..failingPaths.add('/bad.m4b');
        final diagnostics = FakeAppDiagnostics();
        final sut = ImportCleanup(files, diagnostics);
        final pending = {'/good.m4b', '/bad.m4b'};

        await sut.deletePendingFiles(pending);
        files.clearFailure = Exception('picker busy');
        // WHEN
        await sut.clearPickerCache();

        // THEN
        expect(files.deletedPaths, ['/good.m4b', '/bad.m4b']);
        expect(pending, isEmpty);
        expect(diagnostics.operations, [
          'import.cleanup.pending_file',
          'import.cleanup.picker_cache',
        ]);
      },
    );
  });
}

class _Files implements FileImportRepository {
  final failingPaths = <String>{};
  final deletedPaths = <String>[];
  Exception? clearFailure;

  @override
  Future<void> deleteImportedFile(String path) async {
    deletedPaths.add(path);
    if (failingPaths.contains(path)) {
      throw Exception('delete failed');
    }
  }

  @override
  Future<void> clearTemporaryFiles() async {
    if (clearFailure case final failure?) {
      throw failure;
    }
  }

  @override
  Future<List<SelectedAudioFile>> pickAudioFiles() async => const [];

  @override
  Future<List<SelectedAudioFile>> findTransferredAudioFiles() async => const [];

  @override
  Future<ImportedAudioFile> importFile(
    SelectedAudioFile selected, {
    FileCopyProgress? onProgress,
  }) async => ImportedAudioFile(
    path: selected.sourcePath,
    displayName: selected.displayName,
  );

  @override
  Future<void> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {}

  @override
  Future<String?> pickAndImportCover(String bookId) async => null;
}
