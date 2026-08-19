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

  ImportWorkflowCancellation buildCancellation() => ImportWorkflowCancellation(
    selectedFiles: _selectedFiles,
    importedCount: importedCount,
  );

  ImportWorkflowFailure buildFailure(Object error) {
    final kind = _classifyFailure(error);
    final history = _completedStageHistory();

    return ImportWorkflowFailure(
      kind: kind,
      stage: _stage,
      selectedFiles: _selectedFiles,
      importedCount: importedCount,
      stageHistory: history,
      diagnostics: _safeDiagnostics(kind, history),
      failedItem: _failedItem(kind),
      originalRemovalOnly: error is SourceRemovalException,
    );
  }

  ImportFailureKind _classifyFailure(Object error) => switch (error) {
    SourceRemovalException() => ImportFailureKind.sourceRemoval,
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
