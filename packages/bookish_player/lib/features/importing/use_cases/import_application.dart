import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../core/app_metadata.dart';
import '../../../core/foundation/clock.dart';
import '../../../core/foundation/result.dart';
import '../models/import_models.dart';
import '../repos/audiobook_metadata_extractor.dart';
import '../repos/file_import_repository.dart';
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

  Future<Result<ImportResult>> importBooks({
    required bool finderTransfer,
    required ImportProgressCallback onProgress,
  }) async {
    final runtime = _ImportRuntime(_clock, onProgress);
    if (_activeCancellation != null) {
      return Result.failure(
        const AppFailure.operationFailed('import.alreadyRunning'),
        partialValue: runtime.buildFailureKind(ImportFailureKind.unexpected),
      );
    }

    final cancellation = ImportCancellationSignal();
    _activeCancellation = cancellation;

    try {
      final result = await _runImport(finderTransfer, runtime, cancellation);
      return await _completeImport(result, runtime);
    } catch (error) {
      return await _failedResult(
        runtime,
        AppFailure.operationFailed(
          'import.${runtime.stage.name}',
          error: error,
        ),
        runtime.buildFailure(error),
      );
    } finally {
      await _finishImport(finderTransfer, cancellation);
    }
  }

  Future<Result<ImportResult>> _completeImport(
    Result<ImportResult> result,
    _ImportRuntime runtime,
  ) async => switch (result) {
    ResultSuccess() => result,
    ResultFailure(failure: AppFailure(code: AppFailureCode.cancelled)) =>
      _cancelledResult(runtime, result.failure),
    ResultFailure(:final failure) => _failedResult(
      runtime,
      failure,
      runtime.buildFileFailure(failure),
    ),
  };

  Future<Result<ImportResult>> _cancelledResult(
    _ImportRuntime runtime,
    AppFailure failure,
  ) async {
    await _cleanup.deletePendingFiles(runtime.pendingPaths);
    return Result.failure(failure, partialValue: runtime.buildCancellation());
  }

  Future<Result<ImportResult>> _failedResult(
    _ImportRuntime runtime,
    AppFailure failure,
    ImportResult partialValue,
  ) async {
    await _cleanup.deletePendingFiles(runtime.pendingPaths);
    return Result.failure(failure, partialValue: partialValue);
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

  Future<Result<ImportResult>> retryTransferredSourceRemoval({
    required List<SelectedAudioFile> selectedFiles,
    required ImportProgressCallback onProgress,
  }) async {
    final runtime = _removalRuntime(selectedFiles, onProgress);
    try {
      return await _retryRemoval(selectedFiles, runtime);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.sourceRemoval', error: error),
        partialValue: runtime.buildFailure(error),
      );
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

  Future<Result<ImportResult>> _retryRemoval(
    List<SelectedAudioFile> selectedFiles,
    _ImportRuntime runtime,
  ) async => switch (await _removeOriginals(selectedFiles)) {
    ResultSuccess() => Result.success(
      ImportResult(
        selectedFiles: selectedFiles,
        importedCount: selectedFiles.length,
      ),
    ),
    ResultFailure(:final failure) => Result.failure(
      failure,
      partialValue: runtime.buildFileFailure(failure),
    ),
  };

  Future<void> copyDiagnostics(String diagnostics) =>
      _diagnostics.copy(diagnostics);

  Future<Result<ImportResult>> _runImport(
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
        (selection as ResultSuccess<List<SelectedAudioFile>>).value;
    runtime.recordSelection(selected);

    if (selected.isEmpty) {
      return Result.success(
        ImportResult(selectedFiles: selected, importedCount: 0),
      );
    }
    if (cancellation.isCancelled) {
      return const Result.failure(AppFailure.cancelled('import.cancelled'));
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
      return const Result.failure(AppFailure.cancelled('import.cancelled'));
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

  Future<AppFailure?> _importOne(
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
    final imported = (copy as ResultSuccess<ImportedAudioFile>).value;
    runtime.pendingPaths.add(imported.path);
    if (cancellation.isCancelled) {
      return const AppFailure.cancelled('import.cancelled');
    }

    final details = await _readImportedDetails(imported.path, item, runtime);
    if (cancellation.isCancelled) {
      return const AppFailure.cancelled('import.cancelled');
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
      return const AppFailure.cancelled('import.cancelled');
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
    return cancellation.isCancelled
        ? const AppFailure.cancelled('import.cancelled')
        : null;
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

  Future<Result<ImportedAudioFile>> _copySelectedFile(
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

  Future<Result<bool>> _removeOriginals(List<SelectedAudioFile> selected) =>
      _source.removeTransferredFiles(selected);

  String _selectImportedTitle(
    ImportedAudiobookMetadata metadata,
    String fallback,
  ) {
    final title = metadata.title?.trim();
    return title == null || title.isEmpty ? fallback : title;
  }
}
