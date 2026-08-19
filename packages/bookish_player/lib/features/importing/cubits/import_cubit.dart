import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../models/import_models.dart';
import '../use_cases/import_application.dart';
import 'import_cubits.dart';

@injectable
class ImportCubit extends Cubit<ImportState> {
  ImportCubit(this._application) : super(const ImportState());

  final ImportApplication _application;

  Future<void> start() => _runImport(finderTransfer: false);

  Future<void> startFinderTransfer() => _runImport(finderTransfer: true);

  Future<void> retry() async {
    final failure = state.workflowFailure;
    if (failure?.originalRemovalOnly == true &&
        state.selectedFiles.isNotEmpty) {
      await _retryOriginalRemoval();
      return;
    }
    await _runImport(finderTransfer: state.finderTransfer);
  }

  void cancel() {
    if (!state.status.isActive || state.cancellationRequested) {
      return;
    }
    emit(state.copyWith(cancellationRequested: true));
    _application.cancelImport();
  }

  Future<void> copyDiagnostics() async {
    if (state.diagnostics case final diagnostics?) {
      await _application.copyDiagnostics(diagnostics);
    }
  }

  ImportRouteResult get routeResult => ImportRouteResult(
    status: switch (state.status) {
      ImportStatus.complete => ImportRouteStatus.completed,
      ImportStatus.failure => ImportRouteStatus.failed,
      _ => ImportRouteStatus.cancelled,
    },
    importedCount: state.importedCount,
    failedItem: state.workflowFailure?.failedItem,
  );

  Future<void> _runImport({required bool finderTransfer}) async {
    if (state.status.isActive) {
      return;
    }
    emit(
      ImportState(
        finderTransfer: finderTransfer,
        status: ImportStatus.importing,
      ),
    );
    _emitProgress(const ImportProgress(stage: ImportStage.selectingFiles));

    await _importAndEmit(finderTransfer);
  }

  Future<void> _importAndEmit(bool finderTransfer) async {
    final operation = await _application.importBooks(
      finderTransfer: finderTransfer,
      onProgress: _emitProgress,
    );
    _emitOperation(operation, finderTransfer);
  }

  Future<void> _retryOriginalRemoval() async {
    final operation = await _application.retryTransferredSourceRemoval(
      selectedFiles: state.selectedFiles,
      onProgress: _emitProgress,
    );
    _emitOperation(operation, true);
  }

  void _emitOperation(ImportOperationResult operation, bool finderTransfer) =>
      switch (operation) {
        ImportOperationCompleted(:final result) => _emitResult(
          result,
          finderTransfer,
        ),
        ImportOperationCancelled(:final cancellation) => _emitCancellation(
          cancellation,
        ),
        ImportOperationFailed(:final failure) => _captureAndEmitFailure(
          failure,
        ),
      };

  void _emitResult(ImportResult result, bool finderTransfer) {
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
        cancellationRequested: false,
        progress: null,
      ),
    );
  }

  void _emitCancellation(ImportWorkflowCancellation cancellation) {
    emit(
      state.copyWith(
        status: ImportStatus.cancelled,
        selectedFiles: cancellation.selectedFiles,
        workflowFailure: null,
        importedCount: cancellation.importedCount,
        heading: ImportHeading.importCancelled,
        detail: ImportDetail.importCancelled,
        cancellationRequested: false,
        diagnostics: null,
        progress: null,
      ),
    );
  }

  void _captureAndEmitFailure(ImportWorkflowFailure failure) {
    emit(
      state.copyWith(
        status: ImportStatus.failure,
        selectedFiles: failure.selectedFiles,
        workflowFailure: failure,
        importedCount: failure.importedCount,
        heading: _selectFailureHeading(failure),
        detail: failure.originalRemovalOnly
            ? ImportDetail.originalsRemain
            : ImportDetail.stageFailed,
        failureStage: failure.stage,
        cancellationRequested: false,
        diagnostics: failure.diagnostics,
        progress: null,
      ),
    );
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
        cancellationRequested: false,
        diagnostics: null,
        progress: null,
      ),
    );
  }

  void _emitProgress(ImportProgress progress) {
    final fileText = progress.selected?.displayName ?? progress.title;
    emit(
      state.copyWith(
        status: ImportStatus.importing,
        stage: progress.stage,
        importedCount: progress.index,
        totalFiles: progress.total,
        currentTitle: progress.title ?? fileText,
        heading: _progressHeading(progress.stage),
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

  ImportHeading _selectFailureHeading(ImportWorkflowFailure failure) =>
      switch (failure.kind) {
        ImportFailureKind.sourceRemoval => ImportHeading.originalsRemain,
        ImportFailureKind.fileAccess => ImportHeading.fileAccessFailed,
        ImportFailureKind.malformedMetadata => ImportHeading.malformedMetadata,
        ImportFailureKind.unexpected => ImportHeading.importFailed,
      };
}
