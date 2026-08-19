part of 'import_application.dart';

extension on ImportApplication {
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
