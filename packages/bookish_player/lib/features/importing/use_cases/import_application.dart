import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../core/app_metadata.dart';
import '../../../core/foundation/clock.dart';
import '../../../core/foundation/result.dart';
import '../models/import_models.dart';
import '../repos/audiobook_metadata_extractor.dart';
import '../repos/file_import_repository.dart';
import '../repos/file_import_failure.dart';
import '../repos/import_diagnostics_repository.dart';
import '../repos/selected_audio_file.dart';
import 'import_cleanup.dart';
import 'import_item.dart';
import 'import_source_gateway.dart';
import 'import_title.dart';
import 'imported_book_saver.dart';

part 'import_runtime.dart';

typedef _ArtworkRequest = ({
  String importedPath,
  String title,
  ImportedAudiobookMetadata metadata,
  Duration duration,
});

@injectable
class ImportApplication {
  ImportApplication(
    this._source,
    this._bookSaver,
    this._clock,
    this._cleanup,
    this._diagnostics,
  );

  final ImportSourceGateway _source;
  final ImportedBookSaver _bookSaver;
  final Clock _clock;
  final ImportCleanup _cleanup;
  final ImportDiagnosticsRepository _diagnostics;
  ImportCancellationSignal? _activeCancellation;

  Future<ImportOperationResult> importBooks({
    required bool finderTransfer,
    required ImportProgressCallback onProgress,
  }) async {
    final runtime = _ImportRuntime(_clock, onProgress);
    if (_activeCancellation != null) {
      return ImportOperationResult.failed(
        runtime.buildFailureKind(ImportFailureKind.unexpected),
      );
    }

    final cancellation = ImportCancellationSignal();
    _activeCancellation = cancellation;

    try {
      final result = await _runImport(finderTransfer, runtime, cancellation);
      return switch (result) {
        ResultSuccess(:final value) => ImportOperationResult.completed(value),
        ResultFailure(failure: FileImportFailure.cancelled) =>
          await _cancelledResult(runtime),
        ResultFailure(:final failure) => await _failedResult(
          runtime,
          runtime.buildFileFailure(failure),
        ),
      };
    } catch (error) {
      return await _failedResult(runtime, runtime.buildFailure(error));
    } finally {
      await _finishImport(finderTransfer, cancellation);
    }
  }

  Future<ImportOperationResult> _cancelledResult(_ImportRuntime runtime) async {
    await _cleanup.deletePendingFiles(runtime.pendingPaths);
    return ImportOperationResult.cancelled(runtime.buildCancellation());
  }

  Future<ImportOperationResult> _failedResult(
    _ImportRuntime runtime,
    ImportWorkflowFailure failure,
  ) async {
    await _cleanup.deletePendingFiles(runtime.pendingPaths);
    return ImportOperationResult.failed(failure);
  }

  Future<void> _finishImport(
    bool finderTransfer,
    ImportCancellationSignal cancellation,
  ) async {
    if (!finderTransfer) {
      await _cleanup.clearPickerCache();
    }
    if (identical(_activeCancellation, cancellation)) {
      _activeCancellation = null;
    }
  }

  void cancelImport() => _activeCancellation?.cancel();

  Future<ImportOperationResult> retryTransferredSourceRemoval({
    required List<SelectedAudioFile> selectedFiles,
    required ImportProgressCallback onProgress,
  }) async {
    final runtime = _removalRuntime(selectedFiles, onProgress);
    try {
      return await _retryRemoval(selectedFiles, runtime);
    } catch (error) {
      return ImportOperationResult.failed(runtime.buildFailure(error));
    }
  }

  _ImportRuntime _removalRuntime(
    List<SelectedAudioFile> selectedFiles,
    ImportProgressCallback onProgress,
  ) => _ImportRuntime(_clock, onProgress)
    ..recordSelection(selectedFiles)
    ..recordImportedCount(selectedFiles.length)
    ..report(
      ImportProgress(
        stage: ImportStage.removingOriginals,
        total: selectedFiles.length,
      ),
    );

  Future<ImportOperationResult> _retryRemoval(
    List<SelectedAudioFile> selectedFiles,
    _ImportRuntime runtime,
  ) async => switch (await _removeOriginals(selectedFiles)) {
    ResultSuccess() => ImportOperationResult.completed(
      ImportResult(
        selectedFiles: selectedFiles,
        importedCount: selectedFiles.length,
      ),
    ),
    ResultFailure(:final failure) => ImportOperationResult.failed(
      runtime.buildFileFailure(failure),
    ),
  };

  Future<void> copyDiagnostics(String diagnostics) =>
      _diagnostics.copy(diagnostics);

  Future<Result<ImportResult, FileImportFailure>> _runImport(
    bool finderTransfer,
    _ImportRuntime runtime,
    ImportCancellationSignal cancellation,
  ) async {
    runtime.report(const ImportProgress(stage: ImportStage.selectingFiles));
    final selection = await _source.selectFiles(transferred: finderTransfer);
    if (selection case ResultFailure(:final failure)) {
      return Result.failure(failure);
    }
    final selected =
        (selection as ResultSuccess<List<SelectedAudioFile>, FileImportFailure>)
            .value;
    runtime.recordSelection(selected);

    if (selected.isEmpty) {
      return Result.success(
        ImportResult(selectedFiles: selected, importedCount: 0),
      );
    }
    if (cancellation.isCancelled) {
      return const Result.failure(FileImportFailure.cancelled);
    }

    for (var index = 0; index < selected.length; index++) {
      final failure = await _importOne(
        selected[index],
        index,
        selected.length,
        runtime,
        cancellation,
      );
      if (failure != null) {
        return Result.failure(failure);
      }
    }

    if (cancellation.isCancelled) {
      return const Result.failure(FileImportFailure.cancelled);
    }
    if (finderTransfer) {
      runtime.report(
        ImportProgress(
          stage: ImportStage.removingOriginals,
          total: selected.length,
        ),
      );
      final removal = await _removeOriginals(selected);
      if (removal case ResultFailure(:final failure)) {
        return Result.failure(failure);
      }
    }

    return Result.success(
      ImportResult(
        selectedFiles: selected,
        importedCount: runtime.importedCount,
      ),
    );
  }

  Future<FileImportFailure?> _importOne(
    SelectedAudioFile selected,
    int index,
    int total,
    _ImportRuntime runtime,
    ImportCancellationSignal cancellation,
  ) async {
    var item = (
      selected: selected,
      index: index,
      total: total,
      title: audiobookTitleFromFilename(selected.displayName),
    );

    final copy = await _copySelectedFile(item, runtime, cancellation);
    if (copy case ResultFailure(:final failure)) {
      return failure;
    }
    final imported =
        (copy as ResultSuccess<ImportedAudioFile, FileImportFailure>).value;
    runtime.pendingPaths.add(imported.path);
    if (cancellation.isCancelled) {
      return FileImportFailure.cancelled;
    }

    final details = await _readImportedDetails(imported.path, item, runtime);
    if (cancellation.isCancelled) {
      return FileImportFailure.cancelled;
    }
    item = item.withTitle(_selectImportedTitle(details.metadata, item.title));

    runtime.reportItem(item, ImportStage.extractingArtwork);
    final artworkPath = await _resolveArtworkPath(
      (
        importedPath: imported.path,
        title: item.title,
        metadata: details.metadata,
        duration: details.duration,
      ),
      runtime,
      cancellation,
    );
    if (cancellation.isCancelled) {
      return FileImportFailure.cancelled;
    }

    runtime.reportItem(item, ImportStage.savingBook);
    await _bookSaver.save((
      path: imported.path,
      duration: details.duration,
      chapters: details.chapterReport.chapters,
      metadata: details.metadata,
      title: item.title,
      artworkPath: artworkPath,
    ));

    runtime.pendingPaths.remove(imported.path);
    runtime.pendingPaths.remove(artworkPath);
    runtime.recordImported();
    return cancellation.isCancelled ? FileImportFailure.cancelled : null;
  }

  Future<ImportedAudioDetails> _readImportedDetails(
    String path,
    ImportItem item,
    _ImportRuntime runtime,
  ) async {
    runtime.reportItem(item, ImportStage.readingDuration);
    runtime.reportItem(item, ImportStage.analyzingChapters);
    return _source.readDetails(path);
  }

  Future<String?> _resolveArtworkPath(
    _ArtworkRequest request,
    _ImportRuntime runtime,
    ImportCancellationSignal cancellation,
  ) async {
    final archivedMetadata = await _bookSaver.findArchivedMetadata(
      title: request.title,
      author: request.metadata.author ?? '',
      duration: request.duration,
    );
    if (cancellation.isCancelled) {
      return null;
    }

    final artworkPath =
        archivedMetadata?.artworkPath ??
        await _source.extractArtwork(request.importedPath);
    if (artworkPath != null && archivedMetadata?.artworkPath != artworkPath) {
      runtime.pendingPaths.add(artworkPath);
    }
    return artworkPath;
  }

  Future<Result<ImportedAudioFile, FileImportFailure>> _copySelectedFile(
    ImportItem item,
    _ImportRuntime runtime,
    ImportCancellationSignal cancellation,
  ) {
    runtime.reportItem(item, ImportStage.copyingFile);

    return _source.importFile(
      item.selected,
      cancellation: cancellation,
      onProgress: (copiedBytes, totalBytes) => runtime.report(
        ImportProgress(
          stage: ImportStage.copyingFile,
          selected: item.selected,
          index: item.index,
          total: item.total,
          title: item.title,
          copiedBytes: copiedBytes,
          totalBytes: totalBytes,
        ),
      ),
    );
  }

  Future<Result<bool, FileImportFailure>> _removeOriginals(
    List<SelectedAudioFile> selected,
  ) => _source.removeTransferredFiles(selected);

  String _selectImportedTitle(
    ImportedAudiobookMetadata metadata,
    String fallback,
  ) {
    final title = metadata.title?.trim();
    return title == null || title.isEmpty ? fallback : title;
  }
}
