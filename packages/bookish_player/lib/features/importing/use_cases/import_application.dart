import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../core/app_metadata.dart';
import '../../../core/foundation/clock.dart';
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

  Future<ImportResult> importBooks({
    required bool finderTransfer,
    required ImportProgressCallback onProgress,
  }) async {
    if (_activeCancellation != null) {
      throw StateError('An import is already active.');
    }

    final cancellation = ImportCancellationSignal();
    final runtime = _ImportRuntime(_clock, onProgress);
    _activeCancellation = cancellation;

    try {
      return await _runImport(finderTransfer, runtime, cancellation);
    } on ImportCancelledException {
      await _cleanupCancelledImport(runtime);
    } catch (error) {
      await _cleanupFailedImport(runtime, error);
    } finally {
      await _finishImport(finderTransfer, cancellation);
    }
  }

  Future<Never> _cleanupCancelledImport(_ImportRuntime runtime) async {
    await _cleanup.deletePendingFiles(runtime.pendingPaths);
    throw runtime.buildCancellation();
  }

  Future<Never> _cleanupFailedImport(
    _ImportRuntime runtime,
    Object error,
  ) async {
    await _cleanup.deletePendingFiles(runtime.pendingPaths);
    throw runtime.buildFailure(error);
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

  Future<void> retryTransferredSourceRemoval({
    required List<SelectedAudioFile> selectedFiles,
    required ImportProgressCallback onProgress,
  }) async {
    final runtime = _ImportRuntime(_clock, onProgress)
      ..recordSelection(selectedFiles)
      ..recordImportedCount(selectedFiles.length)
      ..report(
        ImportProgress(
          stage: ImportStage.removingOriginals,
          total: selectedFiles.length,
        ),
      );
    try {
      await _removeOriginals(selectedFiles);
    } catch (error) {
      throw runtime.buildFailure(error);
    }
  }

  Future<void> copyDiagnostics(String diagnostics) =>
      _diagnostics.copy(diagnostics);

  Future<ImportResult> _runImport(
    bool finderTransfer,
    _ImportRuntime runtime,
    ImportCancellationSignal cancellation,
  ) async {
    runtime.report(const ImportProgress(stage: ImportStage.selectingFiles));
    final selected = await _source.selectFiles(transferred: finderTransfer);
    runtime.recordSelection(selected);

    if (selected.isEmpty) {
      return ImportResult(selectedFiles: selected, importedCount: 0);
    }
    cancellation.throwIfCancelled();

    for (var index = 0; index < selected.length; index++) {
      await _importOne(
        selected[index],
        index,
        selected.length,
        runtime,
        cancellation,
      );
    }

    cancellation.throwIfCancelled();
    if (finderTransfer) {
      runtime.report(
        ImportProgress(
          stage: ImportStage.removingOriginals,
          total: selected.length,
        ),
      );
      await _removeOriginals(selected);
    }

    return ImportResult(
      selectedFiles: selected,
      importedCount: runtime.importedCount,
    );
  }

  Future<void> _importOne(
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

    final imported = await _copySelectedFile(item, runtime, cancellation);
    runtime.pendingPaths.add(imported.path);
    cancellation.throwIfCancelled();

    final details = await _readImportedDetails(imported.path, item, runtime);
    cancellation.throwIfCancelled();
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
    cancellation.throwIfCancelled();

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
    cancellation.throwIfCancelled();
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
    cancellation.throwIfCancelled();

    final artworkPath =
        archivedMetadata?.artworkPath ??
        await _source.extractArtwork(request.importedPath);
    if (artworkPath != null && archivedMetadata?.artworkPath != artworkPath) {
      runtime.pendingPaths.add(artworkPath);
    }
    return artworkPath;
  }

  Future<ImportedAudioFile> _copySelectedFile(
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

  Future<void> _removeOriginals(List<SelectedAudioFile> selected) async {
    try {
      await _source.removeTransferredFiles(selected);
    } catch (error) {
      throw SourceRemovalException(error);
    }
  }

  String _selectImportedTitle(
    ImportedAudiobookMetadata metadata,
    String fallback,
  ) {
    final title = metadata.title?.trim();
    return title == null || title.isEmpty ? fallback : title;
  }
}
