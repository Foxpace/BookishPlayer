part of 'import_application.dart';

class _ImportRuntime {
  _ImportRuntime(this._clock, this._onProgress);

  final Clock _clock;
  final ImportProgressCallback _onProgress;
  final pendingPaths = <String>{};
  final _stageHistory = <String>[];
  List<SelectedAudioFile> _selectedFiles = const [];
  ImportStage _stage = ImportStage.selectingFiles;
  String? _activeDisplayName;
  DateTime? _stageStartedAt;
  var importedCount = 0;

  ImportStage get stage => _stage;

  void recordSelection(List<SelectedAudioFile> selectedFiles) {
    _selectedFiles = selectedFiles;
  }

  void recordImported() => importedCount++;

  void recordImportedCount(int count) => importedCount = count;

  void reportItem(ImportItem item, ImportStage stage) =>
      report(item.progressFor(stage));

  void report(ImportProgress progress) {
    final now = _clock.now();
    if (_stageStartedAt case final started?) {
      _stageHistory.add(
        '${_stage.name}: ${now.difference(started).inMilliseconds} ms',
      );
    }
    _stageStartedAt = now;
    _stage = progress.stage;
    _activeDisplayName = progress.selected?.displayName;
    _onProgress(progress);
  }

  ImportResult buildCancellation() =>
      ImportResult(selectedFiles: _selectedFiles, importedCount: importedCount);

  ImportResult buildFailure(Object error) {
    final kind = _classifyFailure(error);
    return buildFailureKind(kind);
  }

  ImportResult buildFileFailure(AppFailure failure) =>
      buildFailureKind(switch (failure.detail) {
        'import.sourceRemoval' => ImportFailureKind.sourceRemoval,
        'import.fileAccess' => ImportFailureKind.fileAccess,
        _ => ImportFailureKind.unexpected,
      }, originalRemovalOnly: failure.detail == 'import.sourceRemoval');

  ImportResult buildFailureKind(
    ImportFailureKind kind, {
    bool originalRemovalOnly = false,
  }) {
    final history = _completedStageHistory();

    return ImportResult(
      selectedFiles: _selectedFiles,
      importedCount: importedCount,
      stageHistory: history,
      diagnostics: _safeDiagnostics(kind, history),
      failedItem: _failedItem(kind),
      failureKind: kind,
      failureStage: _stage,
      originalRemovalOnly: originalRemovalOnly,
    );
  }

  ImportFailureKind _classifyFailure(Object error) => switch (error) {
    FileSystemException() => ImportFailureKind.fileAccess,
    FormatException() => ImportFailureKind.malformedMetadata,
    _ => ImportFailureKind.unexpected,
  };

  ImportFailedItem? _failedItem(ImportFailureKind kind) =>
      switch (_activeDisplayName) {
        final displayName? => ImportFailedItem(
          displayName: displayName,
          stage: _stage,
          kind: kind,
        ),
        null => null,
      };

  List<String> _completedStageHistory() {
    final result = [..._stageHistory];
    if (_stageStartedAt case final started?) {
      result.add(
        '${_stage.name} before failure: '
        '${_clock.now().difference(started).inMilliseconds} ms',
      );
    }
    return result;
  }

  String _safeDiagnostics(ImportFailureKind kind, List<String> history) => [
    'Bookish import diagnostic',
    'Operation: import.${_stage.name}',
    'Failure kind: ${kind.name}',
    'Imported before failure: $importedCount',
    'Platform: ${Platform.operatingSystem}',
    'Build: $appVersion',
    if (history.isNotEmpty) ...['Completed stage timings:', ...history],
  ].join('\n');
}
