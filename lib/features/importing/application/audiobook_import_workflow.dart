import 'package:uuid/uuid.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import '../../library/domain/book_metadata.dart';
import '../../library/domain/book_metadata_repository.dart';
import '../../player/domain/audio_player_repository.dart';
import '../domain/audiobook_artwork_extractor.dart';
import '../domain/audiobook_metadata_extractor.dart';
import '../domain/file_import_repository.dart';
import '../domain/m4b_chapter_parser.dart';
import 'import_progress.dart';
import 'import_title.dart';

typedef ImportProgressCallback = void Function(ImportProgress progress);

class AudiobookImportWorkflow {
  AudiobookImportWorkflow(
    this._files,
    this._audio,
    this._books,
    this._bookMetadata,
    this._chapters,
    this._artwork,
    this._metadata,
  );

  final FileImportRepository _files;
  final AudioPlayerRepository _audio;
  final AudiobookCatalogRepository _books;
  final BookMetadataRepository _bookMetadata;
  final M4bChapterParser _chapters;
  final AudiobookArtworkExtractor _artwork;
  final AudiobookMetadataExtractor _metadata;
  final _pendingPaths = <String>{};
  final _stageHistory = <String>[];
  ImportStage _stage = ImportStage.selectingFiles;
  String? _activeFile;
  List<String> _parserDiagnostics = const [];
  DateTime? _stageStartedAt;

  Future<ImportResult> run({
    required bool finderTransfer,
    required ImportProgressCallback onProgress,
  }) async {
    _reset();
    try {
      _progress(
        onProgress,
        const ImportProgress(stage: ImportStage.selectingFiles),
      );
      final selected = finderTransfer
          ? await _files.findTransferredAudioFiles()
          : await _files.pickAudioFiles();
      if (selected.isEmpty) {
        return ImportResult(selectedFiles: selected, importedCount: 0);
      }
      for (var index = 0; index < selected.length; index++) {
        await _importOne(selected[index], index, selected.length, onProgress);
      }
      if (finderTransfer) {
        _progress(
          onProgress,
          ImportProgress(
            stage: ImportStage.removingOriginals,
            total: selected.length,
          ),
        );
        await _removeOriginals(selected);
      }
      return ImportResult(
        selectedFiles: selected,
        importedCount: selected.length,
      );
    } catch (error, stackTrace) {
      await _cleanupPendingImports();
      throw ImportWorkflowFailure(
        error: error,
        stackTrace: stackTrace,
        stage: _stage,
        activeFile: _activeFile,
        parserDiagnostics: _parserDiagnostics,
        stageHistory: _completedStageHistory(),
        originalRemovalOnly: error is SourceRemovalException,
      );
    } finally {
      if (!finderTransfer) {
        await _files.clearTemporaryFiles();
      }
    }
  }

  Future<void> _importOne(
    SelectedAudioFile selected,
    int index,
    int total,
    ImportProgressCallback onProgress,
  ) async {
    var title = audiobookTitleFromFilename(selected.displayName);
    _progress(
      onProgress,
      ImportProgress(
        stage: ImportStage.copyingFile,
        selected: selected,
        index: index,
        total: total,
        title: title,
      ),
    );
    final imported = await _copy(selected, index, total, title, onProgress);
    _pendingPaths.add(imported.path);
    _progress(
      onProgress,
      ImportProgress(
        stage: ImportStage.readingDuration,
        selected: selected,
        index: index,
        total: total,
        title: title,
      ),
    );
    final duration = await _audio.probeDuration(imported.path);
    _progress(
      onProgress,
      ImportProgress(
        stage: ImportStage.analyzingChapters,
        selected: selected,
        index: index,
        total: total,
        title: title,
      ),
    );
    final chapterReport = await _chapters.analyze(imported.path);
    _parserDiagnostics = [
      ...chapterReport.diagnostics,
      ...chapterReport.warnings,
    ];
    final metadata = await _metadata.extract(imported.path);
    title = metadata.title?.trim().isNotEmpty == true
        ? metadata.title!.trim()
        : title;
    _progress(
      onProgress,
      ImportProgress(
        stage: ImportStage.extractingArtwork,
        selected: selected,
        index: index,
        total: total,
        title: title,
      ),
    );
    final archivedMetadata = await _bookMetadata.findBookMetadata(
      bookMetadataFingerprint(
        title: title,
        author: metadata.author ?? '',
        durationMs: duration.inMilliseconds,
      ),
    );
    final artworkPath =
        archivedMetadata?.artworkPath ?? await _artwork.extract(imported.path);
    if (artworkPath != null && archivedMetadata?.artworkPath != artworkPath) {
      _pendingPaths.add(artworkPath);
    }
    _progress(
      onProgress,
      ImportProgress(
        stage: ImportStage.savingBook,
        selected: selected,
        index: index,
        total: total,
        title: title,
      ),
    );
    await _saveBook(
      imported.path,
      duration,
      chapterReport.chapters,
      metadata,
      title,
      artworkPath,
    );
    _pendingPaths.remove(imported.path);
    _pendingPaths.remove(artworkPath);
  }

  Future<ImportedAudioFile> _copy(
    SelectedAudioFile selected,
    int index,
    int total,
    String title,
    ImportProgressCallback onProgress,
  ) {
    return _files.importFile(
      selected,
      onProgress: (copiedBytes, totalBytes) => onProgress(
        ImportProgress(
          stage: ImportStage.copyingFile,
          selected: selected,
          index: index,
          total: total,
          title: title,
          copiedBytes: copiedBytes,
          totalBytes: totalBytes,
        ),
      ),
    );
  }

  Future<void> _saveBook(
    String path,
    Duration duration,
    List<AudioChapter> chapters,
    ImportedAudiobookMetadata metadata,
    String title,
    String? artworkPath,
  ) {
    return _books.saveBook(
      Audiobook(
        id: const Uuid().v4(),
        title: title,
        author: metadata.author ?? '',
        series: metadata.series ?? '',
        narrator: metadata.narrator ?? '',
        year: metadata.year,
        filePath: path,
        durationMs: duration.inMilliseconds,
        addedAt: DateTime.now(),
        chapters: chapters,
        artworkPath: artworkPath,
        artworkScanned: true,
      ),
    );
  }

  Future<void> _removeOriginals(List<SelectedAudioFile> selected) async {
    try {
      await _files.removeTransferredAudioFiles(selected);
    } catch (error) {
      throw SourceRemovalException(error);
    }
  }

  Future<void> retryOriginalRemoval(List<SelectedAudioFile> selected) =>
      _files.removeTransferredAudioFiles(selected);

  void _progress(ImportProgressCallback callback, ImportProgress progress) {
    final now = DateTime.now();
    if (_stageStartedAt case final started?) {
      _stageHistory.add(
        '${_stage.name}: ${now.difference(started).inMilliseconds} ms',
      );
    }
    _stageStartedAt = now;
    _stage = progress.stage;
    _activeFile = progress.selected?.displayName;
    callback(progress);
  }

  List<String> _completedStageHistory() {
    final result = [..._stageHistory];
    if (_stageStartedAt case final started?) {
      result.add(
        '${_stage.name} before failure: ${DateTime.now().difference(started).inMilliseconds} ms',
      );
    }
    return result;
  }

  Future<void> _cleanupPendingImports() async {
    for (final path in _pendingPaths.toList()) {
      try {
        await _files.deleteImportedFile(path);
      } catch (_) {}
    }
    _pendingPaths.clear();
  }

  void _reset() {
    _pendingPaths.clear();
    _stageHistory.clear();
    _stage = ImportStage.selectingFiles;
    _activeFile = null;
    _parserDiagnostics = const [];
    _stageStartedAt = null;
  }
}
