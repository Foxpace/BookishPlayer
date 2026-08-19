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
part 'import_application_pipeline.dart';

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
      return await _executeImport(finderTransfer, runtime, cancellation);
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

  Future<Result<ImportResult>> _executeImport(
    bool finderTransfer,
    _ImportRuntime runtime,
    ImportCancellationSignal cancellation,
  ) async {
    final result = await _runImport(finderTransfer, runtime, cancellation);
    return _completeImport(result, runtime);
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
}
