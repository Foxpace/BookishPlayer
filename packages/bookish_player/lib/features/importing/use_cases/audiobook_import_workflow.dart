import 'package:injectable/injectable.dart';

import '../../../core/foundation/clock.dart';
import '../models/import_runtime_state.dart';
import '../models/import_models.dart';
import '../repos/audiobook_metadata_extractor.dart';
import '../repos/file_import_repository.dart';
import '../repos/selected_audio_file.dart';
import 'import_cleanup.dart';
import 'import_item.dart';
import 'import_title.dart';
import 'import_source_gateway.dart';
import 'imported_book_saver.dart';

@injectable
class AudiobookImportWorkflow {
  AudiobookImportWorkflow(
    this._source,
    this._bookSaver,
    this._clock,
    this._cleanup,
  );

  final ImportSourceGateway _source;
  final ImportedBookSaver _bookSaver;
  final Clock _clock;
  final ImportCleanup _cleanup;

  Future<ImportResult> run({
    required bool finderTransfer,
    required ImportProgressCallback onProgress,
  }) async {
    final runtime = ImportRuntimeState(_clock);
    try {
      return await _runImport(finderTransfer, onProgress, runtime);
    } catch (error, stackTrace) {
      await _cleanupAndThrowImportFailure(error, stackTrace, runtime);
    } finally {
      if (!finderTransfer) {
        await _cleanup.clearPickerCache();
      }
    }
  }

  Future<ImportResult> _runImport(
    bool finderTransfer,
    ImportProgressCallback onProgress,
    ImportRuntimeState runtime,
  ) async {
    _reportProgress(
      onProgress,
      const ImportProgress(stage: ImportStage.selectingFiles),
      runtime,
    );
    final selected = await _source.selectFiles(transferred: finderTransfer);

    if (selected.isEmpty) {
      return ImportResult(selectedFiles: selected, importedCount: 0);
    }

    for (var index = 0; index < selected.length; index++) {
      await _importOne(
        selected[index],
        index,
        selected.length,
        onProgress,
        runtime,
      );
    }

    if (finderTransfer) {
      await _removeTransferredOriginals(selected, onProgress, runtime);
    }

    return ImportResult(
      selectedFiles: selected,
      importedCount: selected.length,
    );
  }

  Future<Never> _cleanupAndThrowImportFailure(
    Object error,
    StackTrace stackTrace,
    ImportRuntimeState runtime,
  ) async {
    await _cleanup.deletePendingFiles(runtime.pendingPaths);
    throw runtime.buildFailure(error, stackTrace);
  }

  Future<void> _importOne(
    SelectedAudioFile selected,
    int index,
    int total,
    ImportProgressCallback onProgress,
    ImportRuntimeState runtime,
  ) async {
    var item = (
      selected: selected,
      index: index,
      total: total,
      title: audiobookTitleFromFilename(selected.displayName),
    );

    final imported = await _copySelectedFile(item, onProgress, runtime);
    runtime.pendingPaths.add(imported.path);

    final details = await _readImportedDetails(
      imported.path,
      item,
      onProgress,
      runtime,
    );
    item = item.withTitle(_selectImportedTitle(details.metadata, item.title));

    _reportItemStage(onProgress, item, ImportStage.extractingArtwork, runtime);
    final artworkPath = await _resolveArtworkPath(
      imported.path,
      item.title,
      details.metadata,
      details.duration,
      runtime,
    );

    _reportItemStage(onProgress, item, ImportStage.savingBook, runtime);
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
  }

  Future<ImportedAudioDetails> _readImportedDetails(
    String path,
    ImportItem item,
    ImportProgressCallback onProgress,
    ImportRuntimeState runtime,
  ) async {
    _reportItemStage(onProgress, item, ImportStage.readingDuration, runtime);
    _reportItemStage(onProgress, item, ImportStage.analyzingChapters, runtime);
    final details = await _source.readDetails(path);
    runtime.recordParserDiagnostics([
      ...details.chapterReport.diagnostics,
      ...details.chapterReport.warnings,
    ]);

    return details;
  }

  Future<String?> _resolveArtworkPath(
    String importedPath,
    String title,
    ImportedAudiobookMetadata metadata,
    Duration duration,
    ImportRuntimeState runtime,
  ) async {
    final archivedMetadata = await _bookSaver.findArchivedMetadata(
      title: title,
      author: metadata.author ?? '',
      duration: duration,
    );

    final artworkPath =
        archivedMetadata?.artworkPath ??
        await _source.extractArtwork(importedPath);
    if (artworkPath != null && archivedMetadata?.artworkPath != artworkPath) {
      runtime.pendingPaths.add(artworkPath);
    }

    return artworkPath;
  }

  String _selectImportedTitle(
    ImportedAudiobookMetadata metadata,
    String fallback,
  ) {
    final title = metadata.title?.trim();
    return title == null || title.isEmpty ? fallback : title;
  }

  Future<ImportedAudioFile> _copySelectedFile(
    ImportItem item,
    ImportProgressCallback onProgress,
    ImportRuntimeState runtime,
  ) {
    _reportItemStage(onProgress, item, ImportStage.copyingFile, runtime);

    return _source.importFile(
      item.selected,
      onProgress: (copiedBytes, totalBytes) => onProgress(
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

  Future<void> _removeTransferredOriginals(
    List<SelectedAudioFile> selected,
    ImportProgressCallback onProgress,
    ImportRuntimeState runtime,
  ) async {
    _reportProgress(
      onProgress,
      ImportProgress(
        stage: ImportStage.removingOriginals,
        total: selected.length,
      ),
      runtime,
    );

    await _removeOriginals(selected);
  }

  void _reportItemStage(
    ImportProgressCallback callback,
    ImportItem item,
    ImportStage stage,
    ImportRuntimeState runtime,
  ) {
    _reportProgress(callback, item.progressFor(stage), runtime);
  }

  Future<void> retryOriginalRemoval(List<SelectedAudioFile> selected) =>
      _source.removeTransferredFiles(selected);

  void _reportProgress(
    ImportProgressCallback callback,
    ImportProgress progress,
    ImportRuntimeState runtime,
  ) => runtime.trackProgress(callback, progress);
}
