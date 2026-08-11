import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/app_metadata.dart';
import '../../../core/diagnostics/app_error.dart';
import '../use_cases/importing_use_cases.dart';
import '../models/import_models.dart';
import 'import_cubits.dart';

@injectable
class ImportCubit extends Cubit<ImportState> {
  ImportCubit(this._useCases) : super(const ImportState());

  final ImportUseCases _useCases;

  Future<void> start() => _runImport(finderTransfer: false);

  Future<void> startFinderTransfer() => _runImport(finderTransfer: true);

  Future<void> _runImport({required bool finderTransfer}) async {
    emit(state.copyWith(finderTransfer: finderTransfer, workflowFailure: null));
    _emitProgress(const ImportProgress(stage: ImportStage.selectingFiles));
    try {
      await _runWorkflowAndEmit(finderTransfer);
    } on ImportWorkflowFailure catch (failure) {
      _captureAndEmitFailure(failure);
    }
  }

  Future<void> retry() async {
    final failure = state.workflowFailure;
    if (failure?.originalRemovalOnly == true &&
        state.selectedFiles.isNotEmpty) {
      await _retryOriginalRemoval();
      return;
    }
    await _runImport(finderTransfer: state.finderTransfer);
  }

  Future<void> _retryOriginalRemoval() async {
    try {
      await _retryOriginalRemovalAndEmit();
    } catch (error, stackTrace) {
      _captureOriginalRemovalFailure(error, stackTrace);
    }
  }

  Future<void> _runWorkflowAndEmit(bool finderTransfer) async {
    final result = await _useCases.importBook(
      finderTransfer: finderTransfer,
      onProgress: _emitProgress,
    );
    if (result.selectedFiles.isEmpty) {
      _emitEmptySelection(finderTransfer);
      return;
    }
    emit(
      state.copyWith(
        status: ImportStatus.complete,
        selectedFiles: result.selectedFiles,
        workflowFailure: null,
        importedCount: result.importedCount,
        progress: null,
      ),
    );
  }

  void _captureAndEmitFailure(ImportWorkflowFailure failure) {
    emit(
      state.copyWith(
        status: ImportStatus.failure,
        workflowFailure: failure,
        heading: _selectFailureHeading(failure),
        detail: _selectFailureDetail(failure),
        failureStage: failure.stage,
        diagnostics: _buildDiagnostics(failure),
        progress: null,
      ),
    );
  }

  Future<void> _retryOriginalRemovalAndEmit() async {
    await _useCases.removeTransferredSources(state.selectedFiles);
    emit(state.copyWith(status: ImportStatus.complete, workflowFailure: null));
  }

  void _captureOriginalRemovalFailure(Object error, StackTrace stackTrace) {
    _captureAndEmitFailure(
      ImportWorkflowFailure(
        error: error,
        stackTrace: stackTrace,
        stage: ImportStage.removingOriginals,
        stageHistory: const [],
        originalRemovalOnly: true,
      ),
    );
  }

  Future<void> copyDiagnostics() async {
    final value = state.diagnostics;
    if (value != null) {
      await _useCases.copyDiagnostics(value);
    }
  }

  void _emitEmptySelection(bool finderTransfer) {
    emit(
      state.copyWith(
        status: finderTransfer ? ImportStatus.failure : ImportStatus.cancelled,
        selectedFiles: const [],
        heading: finderTransfer
            ? ImportHeading.noTransferredAudiobooks
            : ImportHeading.noFilesSelected,
        detail: finderTransfer
            ? ImportDetail.finderInstructions
            : ImportDetail.selectionCancelled,
        diagnostics: null,
        progress: null,
      ),
    );
  }

  void _emitProgress(ImportProgress progress) {
    final heading = _progressHeading(progress.stage);
    final fileText = progress.selected?.displayName ?? progress.title;

    emit(
      state.copyWith(
        status: ImportStatus.importing,
        stage: progress.stage,
        importedCount: progress.index,
        totalFiles: progress.total,
        currentTitle: progress.title ?? fileText,
        heading: heading,
        detail: _selectProgressDetail(progress),
        copiedBytes: progress.copiedBytes,
        totalBytes: progress.totalBytes,
        progress: _calculateProgressValue(progress),
        diagnostics: null,
      ),
    );
  }

  ImportHeading _progressHeading(ImportStage stage) => switch (stage) {
    ImportStage.selectingFiles => ImportHeading.preparingSelection,
    ImportStage.copyingFile => ImportHeading.copyingAudiobook,
    ImportStage.readingDuration => ImportHeading.readingAudioInformation,
    ImportStage.analyzingChapters => ImportHeading.analyzingChapters,
    ImportStage.extractingArtwork => ImportHeading.extractingArtwork,
    ImportStage.savingBook => ImportHeading.savingToLibrary,
    ImportStage.removingOriginals => ImportHeading.removingOriginals,
  };

  ImportDetail _selectProgressDetail(ImportProgress progress) {
    if (progress.copiedBytes != null) {
      return ImportDetail.copyProgress;
    }
    if (progress.stage == ImportStage.removingOriginals) {
      return ImportDetail.removingOriginals;
    }
    return ImportDetail.keepAppOpen;
  }

  double? _calculateProgressValue(ImportProgress progress) {
    final copied = progress.copiedBytes;
    final bytes = progress.totalBytes;
    if (copied != null && bytes != null && bytes > 0) {
      return ((progress.index + copied / bytes) / progress.total).clamp(0, 1);
    }
    return progress.total > 1 ? progress.index / progress.total : null;
  }

  ImportHeading _selectFailureHeading(ImportWorkflowFailure failure) {
    if (failure.originalRemovalOnly) {
      return ImportHeading.originalsRemain;
    }
    if (failure.error is FileSystemException) {
      return ImportHeading.fileAccessFailed;
    }
    if (failure.error is FormatException) {
      return ImportHeading.malformedMetadata;
    }
    return ImportHeading.importFailed;
  }

  ImportDetail _selectFailureDetail(ImportWorkflowFailure failure) {
    if (failure.originalRemovalOnly) {
      return ImportDetail.originalsRemain;
    }
    return ImportDetail.stageFailed;
  }

  String _buildDiagnostics(ImportWorkflowFailure failure) =>
      AppError(
        time: DateTime.now().toIso8601String(),
        operation: 'import.${failure.stage.name}',
        errorType: failure.error.runtimeType.toString(),
        message: '${failure.error}',
        stack: '${failure.stackTrace}',
        platform: Platform.operatingSystem,
        platformVersion: Platform.operatingSystemVersion,
        build: appVersion,
        context: {'Stage': failure.stage.name, 'File': ?failure.activeFile},
        history: failure.stageHistory,
        diagnostics: failure.parserDiagnostics,
      ).toDiagnosticText(
        title: 'Bookish import diagnostic',
        historyTitle: 'Completed stage timings:',
        diagnosticsTitle: 'Latest chapter-parser analysis:',
      );
}
