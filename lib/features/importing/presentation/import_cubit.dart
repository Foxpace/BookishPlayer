import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/diagnostic_failure.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import '../../library/domain/book_metadata_repository.dart';
import '../../player/domain/audio_player_repository.dart';
import '../application/audiobook_import_workflow.dart';
import '../application/import_progress.dart';
import '../domain/audiobook_artwork_extractor.dart';
import '../domain/audiobook_metadata_extractor.dart';
import '../domain/file_import_repository.dart';
import '../domain/import_diagnostics_repository.dart';
import '../domain/m4b_chapter_parser.dart';
import 'import_state.dart';

@injectable
class ImportCubit extends Cubit<ImportState> {
  ImportCubit(
    FileImportRepository files,
    AudioPlayerRepository audio,
    AudiobookCatalogRepository books,
    BookMetadataRepository bookMetadata,
    M4bChapterParser chapters,
    AudiobookArtworkExtractor artwork,
    AudiobookMetadataExtractor metadata,
    this._diagnostics,
  ) : _workflow = AudiobookImportWorkflow(
        files,
        audio,
        books,
        bookMetadata,
        chapters,
        artwork,
        metadata,
      ),
      super(const ImportState());

  final AudiobookImportWorkflow _workflow;
  final ImportDiagnosticsRepository _diagnostics;
  var _finderTransfer = false;
  List<SelectedAudioFile> _selectedFiles = const [];
  ImportWorkflowFailure? _failure;

  Future<void> start() => _run(finderTransfer: false);

  Future<void> startFinderTransfer() => _run(finderTransfer: true);

  Future<void> _run({required bool finderTransfer}) async {
    _finderTransfer = finderTransfer;
    _failure = null;
    _emitProgress(const ImportProgress(stage: ImportStage.selectingFiles));
    try {
      final result = await _workflow.run(
        finderTransfer: finderTransfer,
        onProgress: _emitProgress,
      );
      _selectedFiles = result.selectedFiles;
      if (result.selectedFiles.isEmpty) {
        _emitEmptySelection(finderTransfer);
        return;
      }
      emit(
        state.copyWith(
          status: ImportStatus.complete,
          importedCount: result.importedCount,
          progress: null,
        ),
      );
    } on ImportWorkflowFailure catch (failure) {
      _failure = failure;
      emit(
        state.copyWith(
          status: ImportStatus.failure,
          heading: _failureHeading(failure),
          detail: _failureDetail(failure),
          diagnostics: _buildDiagnostics(failure),
          progress: null,
        ),
      );
    }
  }

  Future<void> retry() async {
    final failure = _failure;
    if (failure?.originalRemovalOnly == true && _selectedFiles.isNotEmpty) {
      await _retryOriginalRemoval();
      return;
    }
    await _run(finderTransfer: _finderTransfer);
  }

  Future<void> _retryOriginalRemoval() async {
    try {
      await _workflow.retryOriginalRemoval(_selectedFiles);
      emit(state.copyWith(status: ImportStatus.complete));
    } catch (error, stackTrace) {
      final failure = ImportWorkflowFailure(
        error: error,
        stackTrace: stackTrace,
        stage: ImportStage.removingOriginals,
        stageHistory: const [],
        originalRemovalOnly: true,
      );
      _failure = failure;
      emit(
        state.copyWith(
          status: ImportStatus.failure,
          heading: _failureHeading(failure),
          detail: _failureDetail(failure),
          diagnostics: _buildDiagnostics(failure),
        ),
      );
    }
  }

  Future<void> copyDiagnostics() async {
    final value = state.diagnostics;
    if (value != null) {
      await _diagnostics.copy(value);
    }
  }

  void _emitEmptySelection(bool finderTransfer) {
    emit(
      state.copyWith(
        status: finderTransfer ? ImportStatus.failure : ImportStatus.cancelled,
        heading: finderTransfer
            ? 'No transferred audiobooks found'
            : 'No files were selected',
        detail: finderTransfer
            ? 'In Finder, select your iPhone, open Files > Bookish, then drag audiobooks directly into the Bookish file area.'
            : 'Android did not return any files to Bookish. You can open the file browser again or return to your library.',
        diagnostics: null,
        progress: null,
      ),
    );
  }

  void _emitProgress(ImportProgress progress) {
    final stageText = switch (progress.stage) {
      ImportStage.selectingFiles => 'Preparing file selection',
      ImportStage.copyingFile => 'Copying audiobook',
      ImportStage.readingDuration => 'Reading audio information',
      ImportStage.analyzingChapters => 'Analyzing chapters',
      ImportStage.extractingArtwork => 'Extracting cover artwork',
      ImportStage.savingBook => 'Saving to your library',
      ImportStage.removingOriginals => 'Removing originals',
    };
    final fileText = progress.selected?.displayName ?? progress.title;
    emit(
      state.copyWith(
        status: ImportStatus.importing,
        stage: progress.stage,
        importedCount: progress.index,
        totalFiles: progress.total,
        currentTitle: progress.title ?? fileText,
        heading: stageText,
        detail: _progressDetail(progress, fileText),
        progress: _progressValue(progress),
        diagnostics: null,
      ),
    );
  }

  String _progressDetail(ImportProgress progress, String? fileText) {
    if (progress.copiedBytes case final copied?) {
      return '${progress.selected?.displayName}\n'
          '${_formatBytes(copied)} of ${_formatBytes(progress.totalBytes ?? 0)} copied';
    }
    if (progress.stage == ImportStage.removingOriginals) {
      return 'The audiobook is safely copied. Bookish is now removing the selected original files.';
    }
    return fileText == null
        ? 'Please keep Bookish open for a moment.'
        : '$fileText\nPlease keep Bookish open for a moment.';
  }

  double? _progressValue(ImportProgress progress) {
    final copied = progress.copiedBytes;
    final bytes = progress.totalBytes;
    if (copied != null && bytes != null && bytes > 0) {
      return ((progress.index + copied / bytes) / progress.total).clamp(0, 1);
    }
    return progress.total > 1 ? progress.index / progress.total : null;
  }

  String _failureHeading(ImportWorkflowFailure failure) {
    if (failure.originalRemovalOnly) {
      return 'The book was copied, but the originals remain';
    }
    if (failure.error is FileSystemException) {
      return 'Bookish could not access that file';
    }
    if (failure.error is FormatException) {
      return 'The audiobook metadata is malformed';
    }
    return 'The audiobook could not be imported';
  }

  String _failureDetail(ImportWorkflowFailure failure) {
    if (failure.originalRemovalOnly) {
      return 'The document provider did not allow Bookish to delete one or more originals. Your imported copy is safe. You can retry deletion or remove the originals in the Files app.';
    }
    final stage = switch (failure.stage) {
      ImportStage.selectingFiles =>
        'receiving the file from the document provider',
      ImportStage.copyingFile => 'copying the file into Bookish',
      ImportStage.readingDuration => 'opening the audio stream',
      ImportStage.analyzingChapters => 'analyzing embedded chapters',
      ImportStage.extractingArtwork => 'reading embedded cover artwork',
      ImportStage.savingBook => 'saving the library entry',
      ImportStage.removingOriginals => 'removing the selected original files',
    };
    return '${diagnosticFailureMessage('The failure happened while $stage.', failure.error)}\n'
        'The full diagnostic below can be copied when reporting the problem.';
  }

  String _buildDiagnostics(ImportWorkflowFailure failure) => [
    'Bookish import diagnostic',
    'Time: ${DateTime.now().toIso8601String()}',
    'Stage: ${failure.stage.name}',
    if (failure.activeFile != null) 'File: ${failure.activeFile}',
    'Platform: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
    'Error type: ${failure.error.runtimeType}',
    'Error: ${failure.error}',
    '',
    'Completed stage timings:',
    if (failure.stageHistory.isEmpty) 'None' else ...failure.stageHistory,
    if (failure.parserDiagnostics.isNotEmpty) ...[
      '',
      'Latest chapter-parser analysis:',
      ...failure.parserDiagnostics,
    ],
    '',
    'Stack trace:',
    '${failure.stackTrace}',
  ].join('\n');

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
