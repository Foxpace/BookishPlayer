import 'package:bookish_player/core/foundation/result.dart';
import 'package:bookish_player/features/importing/models/import_cancellation.dart';
import 'package:bookish_player/features/importing/repos/file_import_repository.dart';
import 'package:bookish_player/features/importing/repos/selected_audio_file.dart';
import 'package:bookish_player/features/importing/use_cases/import_cleanup.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fakes/fake_app_diagnostics.dart';

void main() {
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
  Future<Result<List<SelectedAudioFile>>> pickAudioFiles() async =>
      const Result.success([]);

  @override
  Future<Result<List<SelectedAudioFile>>> findTransferredAudioFiles() async =>
      const Result.success([]);

  @override
  Future<Result<ImportedAudioFile>> importFile(
    SelectedAudioFile selected, {
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  }) async => Result.success(
    ImportedAudioFile(
      path: selected.sourcePath,
      displayName: selected.displayName,
    ),
  );

  @override
  Future<Result<bool>> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async => const Result.success(true);

  @override
  Future<String?> pickAndImportCover(String bookId) async => null;
}
