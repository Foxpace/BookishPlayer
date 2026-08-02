import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_repository.dart';
import '../../player/domain/audio_player_repository.dart';
import '../domain/audiobook_artwork_extractor.dart';
import '../domain/audiobook_metadata_extractor.dart';
import '../domain/file_import_repository.dart';
import '../domain/import_diagnostics_repository.dart';
import '../domain/m4b_chapter_parser.dart';
import 'import_state.dart';

@injectable
class ImportCubit extends Cubit<ImportState> {
  ImportCubit(
    this._files,
    this._audio,
    this._books,
    this._chapters,
    this._artwork,
    this._metadata,
    this._diagnostics,
  ) : super(const ImportState());

  final FileImportRepository _files;
  final AudioPlayerRepository _audio;
  final AudiobookRepository _books;
  final M4bChapterParser _chapters;
  final AudiobookArtworkExtractor _artwork;
  final AudiobookMetadataExtractor _metadata;
  final ImportDiagnosticsRepository _diagnostics;
  ImportStage _activeStage = ImportStage.selectingFiles;
  String? _activeFile;
  List<String> _parserDiagnostics = const [];
  DateTime? _stageStartedAt;
  final _stageHistory = <String>[];
  final _pendingImportedPaths = <String>{};
  Future<void> Function()? _retryAction;

  Future<void> start() async {
    await _start(_files.pickAudioFiles, clearTemporaryFilesAfterImport: true);
  }

  Future<void> startFinderTransfer() async {
    await _start(
      _files.findTransferredAudioFiles,
      emptyHeading: 'No transferred audiobooks found',
      emptyDetail:
          'In Finder, select your iPhone, open Files > Bookish, then drag audiobooks directly into the Bookish file area.',
      removeAfterImport: true,
    );
  }

  Future<void> _start(
    Future<List<SelectedAudioFile>> Function() selectFiles, {
    String? emptyHeading,
    String? emptyDetail,
    bool removeAfterImport = false,
    bool clearTemporaryFilesAfterImport = false,
  }) async {
    _retryAction = () => _start(
      selectFiles,
      emptyHeading: emptyHeading,
      emptyDetail: emptyDetail,
      removeAfterImport: removeAfterImport,
      clearTemporaryFilesAfterImport: clearTemporaryFilesAfterImport,
    );
    try {
      _activeFile = null;
      _parserDiagnostics = const [];
      _pendingImportedPaths.clear();
      _stageStartedAt = null;
      _stageHistory.clear();
      _emitStage(
        ImportStage.selectingFiles,
        heading: 'Preparing file selection',
        detail: 'Waiting for your device’s document provider…',
      );
      final selectedFiles = await selectFiles();
      if (selectedFiles.isEmpty) {
        if (emptyHeading == null) {
          emit(
            state.copyWith(
              status: ImportStatus.cancelled,
              heading: 'No files were selected',
              detail:
                  'Android did not return any files to Bookish. You can open '
                  'the file browser again or return to your library.',
              progress: null,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: ImportStatus.failure,
              heading: emptyHeading,
              detail: emptyDetail ?? '',
              diagnostics: null,
              progress: null,
            ),
          );
        }
        return;
      }
      for (var index = 0; index < selectedFiles.length; index++) {
        final selected = selectedFiles[index];
        var title = _titleFromFilename(selected.displayName);
        _emitStage(
          ImportStage.copyingFile,
          selected: selected,
          index: index,
          total: selectedFiles.length,
          title: title,
        );
        final copied = await _copySelectedFile(
          selected,
          fileIndex: index,
          fileCount: selectedFiles.length,
          completedBytes: 0,
          batchBytes: selected.sizeBytes ?? 0,
        );
        final file = copied.file;
        _pendingImportedPaths.add(file.path);
        _emitStage(
          ImportStage.readingDuration,
          selected: selected,
          index: index,
          total: selectedFiles.length,
          title: title,
        );
        final duration = await _audio.probeDuration(file.path);
        _emitStage(
          ImportStage.analyzingChapters,
          selected: selected,
          index: index,
          total: selectedFiles.length,
          title: title,
        );
        final chapterReport = await _chapters.analyze(file.path);
        _parserDiagnostics = [
          ...chapterReport.diagnostics,
          ...chapterReport.warnings,
        ];
        final metadata = await _metadata.extract(file.path);
        title = metadata.title?.trim().isNotEmpty == true
            ? metadata.title!.trim()
            : title;
        _emitStage(
          ImportStage.extractingArtwork,
          selected: selected,
          index: index,
          total: selectedFiles.length,
          title: title,
        );
        final artworkPath = await _artwork.extract(file.path);
        if (artworkPath != null) {
          _pendingImportedPaths.add(artworkPath);
        }
        _emitStage(
          ImportStage.savingBook,
          selected: selected,
          index: index,
          total: selectedFiles.length,
          title: title,
        );
        await _books.saveBook(
          Audiobook(
            id: const Uuid().v4(),
            title: title,
            author: metadata.author ?? '',
            series: metadata.series ?? '',
            narrator: metadata.narrator ?? '',
            year: metadata.year,
            filePath: file.path,
            durationMs: duration.inMilliseconds,
            addedAt: DateTime.now(),
            chapters: chapterReport.chapters,
            artworkPath: artworkPath,
            artworkScanned: true,
          ),
        );
        _pendingImportedPaths.remove(file.path);
        if (artworkPath != null) {
          _pendingImportedPaths.remove(artworkPath);
        }
      }
      if (removeAfterImport) {
        await _removeOriginals(selectedFiles);
      }
      emit(
        state.copyWith(
          status: ImportStatus.complete,
          importedCount: selectedFiles.length,
        ),
      );
    } catch (error, stackTrace) {
      await _cleanupPendingImports();
      emit(
        state.copyWith(
          status: ImportStatus.failure,
          heading: _failureHeading(error),
          detail: _failureDetail(error),
          diagnostics: _buildDiagnostics(error, stackTrace),
          progress: null,
        ),
      );
    } finally {
      if (clearTemporaryFilesAfterImport) {
        await _files.clearTemporaryFiles();
      }
    }
  }

  Future<void> _cleanupPendingImports() async {
    for (final path in _pendingImportedPaths.toList()) {
      try {
        await _files.deleteImportedFile(path);
      } catch (_) {
        // Preserve the original import failure in diagnostics.
      }
    }
    _pendingImportedPaths.clear();
  }

  Future<({ImportedAudioFile file, int totalBytes})> _copySelectedFile(
    SelectedAudioFile selected, {
    required int fileIndex,
    required int fileCount,
    required int completedBytes,
    required int batchBytes,
  }) async {
    var actualTotalBytes = selected.sizeBytes ?? 0;
    final file = await _files.importFile(
      selected,
      onProgress: (copiedBytes, totalBytes) {
        actualTotalBytes = totalBytes;
        final progress = batchBytes > 0
            ? (completedBytes + copiedBytes) / batchBytes
            : totalBytes > 0
            ? (fileIndex + copiedBytes / totalBytes) / fileCount
            : null;
        emit(
          state.copyWith(
            status: ImportStatus.importing,
            stage: ImportStage.copyingFile,
            importedCount: fileIndex,
            totalFiles: fileCount,
            heading: 'Copying audiobook',
            detail:
                '${selected.displayName}\n'
                '${_formatBytes(copiedBytes)} of ${_formatBytes(totalBytes)} copied',
            progress: progress?.clamp(0.0, 1.0),
          ),
        );
      },
    );
    return (file: file, totalBytes: actualTotalBytes);
  }

  Future<void> copyDiagnostics() async {
    final value = state.diagnostics;
    if (value != null) {
      await _diagnostics.copy(value);
    }
  }

  Future<void> retry() => _retryAction?.call() ?? start();

  Future<void> _removeOriginals(List<SelectedAudioFile> files) async {
    try {
      _emitStage(
        ImportStage.removingOriginals,
        total: files.length,
        heading: 'Removing originals',
        detail:
            'The audiobook is safely copied. Bookish is now removing the '
            'selected original ${files.length == 1 ? 'file' : 'files'}.',
      );
      await _files.removeTransferredAudioFiles(files);
    } catch (error) {
      _retryAction = () => _retryOriginalRemoval(files);
      throw _SourceRemovalException(error);
    }
  }

  Future<void> _retryOriginalRemoval(List<SelectedAudioFile> files) async {
    try {
      await _files.removeTransferredAudioFiles(files);
      emit(state.copyWith(status: ImportStatus.complete));
    } catch (error, stackTrace) {
      final wrapped = _SourceRemovalException(error);
      emit(
        state.copyWith(
          status: ImportStatus.failure,
          heading: _failureHeading(wrapped),
          detail: _failureDetail(wrapped),
          diagnostics: _buildDiagnostics(wrapped, stackTrace),
        ),
      );
    }
  }

  void _emitStage(
    ImportStage stage, {
    SelectedAudioFile? selected,
    int index = 0,
    int total = 0,
    String? title,
    String? heading,
    String? detail,
  }) {
    final now = DateTime.now();
    if (_stageStartedAt case final started?) {
      _stageHistory.add(
        '${_activeStage.name}: ${now.difference(started).inMilliseconds} ms',
      );
    }
    _stageStartedAt = now;
    _activeStage = stage;
    _activeFile = selected?.displayName;
    final stageText = switch (stage) {
      ImportStage.selectingFiles => 'Preparing file selection',
      ImportStage.copyingFile => 'Copying audiobook',
      ImportStage.readingDuration => 'Reading audio information',
      ImportStage.analyzingChapters => 'Analyzing chapters',
      ImportStage.extractingArtwork => 'Extracting cover artwork',
      ImportStage.savingBook => 'Saving to your library',
      ImportStage.removingOriginals => 'Removing originals',
    };
    final fileText = selected?.displayName ?? title;
    emit(
      state.copyWith(
        status: ImportStatus.importing,
        stage: stage,
        importedCount: index,
        totalFiles: total,
        currentTitle: title ?? fileText,
        heading: heading ?? stageText,
        detail:
            detail ??
            (fileText == null
                ? 'Please keep Bookish open for a moment.'
                : '$fileText\nPlease keep Bookish open for a moment.'),
        progress: total > 1 ? index / total : null,
        diagnostics: null,
      ),
    );
  }

  String _failureHeading(Object error) {
    if (error is _SourceRemovalException) {
      return 'The book was copied, but the originals remain';
    }
    if (error is FileSystemException) {
      return 'Bookish could not access that file';
    }
    if (error is FormatException) {
      return 'The audiobook metadata is malformed';
    }
    return 'The audiobook could not be imported';
  }

  String _failureDetail(Object error) {
    if (error is _SourceRemovalException) {
      return 'The document provider did not allow Bookish to delete one or '
          'more originals. Your imported copy is safe. You can retry deletion '
          'or remove the originals in the Files app.';
    }
    final stage = switch (_activeStage) {
      ImportStage.selectingFiles =>
        'receiving the file from the document provider',
      ImportStage.copyingFile => 'copying the file into Bookish',
      ImportStage.readingDuration => 'opening the audio stream',
      ImportStage.analyzingChapters => 'analyzing embedded chapters',
      ImportStage.extractingArtwork => 'reading embedded cover artwork',
      ImportStage.savingBook => 'saving the library entry',
      ImportStage.removingOriginals => 'removing the selected original files',
    };
    final advice = error is FileSystemException
        ? 'Check that the file is still available, fully downloaded, and that the device has enough free storage.'
        : 'The detailed diagnostic below can be copied when reporting the problem.';
    return 'The failure happened while $stage. $advice';
  }

  String _buildDiagnostics(Object error, StackTrace stackTrace) {
    final lines = <String>[
      'Bookish import diagnostic',
      'Time: ${DateTime.now().toIso8601String()}',
      'Stage: ${_activeStage.name}',
      if (_activeFile != null) 'File: $_activeFile',
      'Platform: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
      'Error type: ${error.runtimeType}',
      'Error: $error',
      '',
      'Completed stage timings:',
      if (_stageHistory.isEmpty) 'None' else ..._stageHistory,
      if (_stageStartedAt case final started?)
        '${_activeStage.name} before failure: '
            '${DateTime.now().difference(started).inMilliseconds} ms',
      '',
      'Stack trace:',
      '$stackTrace',
    ];
    if (_parserDiagnostics.isNotEmpty) {
      lines.addAll([
        '',
        'Latest chapter-parser analysis:',
        ..._parserDiagnostics,
      ]);
    }
    return lines.join('\n');
  }

  String _titleFromFilename(String filename) {
    final raw = p
        .basenameWithoutExtension(filename)
        .replaceAll(RegExp('[_-]+'), ' ')
        .trim();
    if (raw.isEmpty) {
      return 'Untitled audiobook';
    }
    return raw
        .split(RegExp(r'\s+'))
        .map(
          (word) => word.isEmpty
              ? word
              : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }

  String _formatBytes(int bytes) {
    if (bytes >= 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    if (bytes >= 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '$bytes B';
  }
}

class _SourceRemovalException implements Exception {
  const _SourceRemovalException(this.cause);

  final Object cause;

  @override
  String toString() => 'Could not remove original files: $cause';
}
