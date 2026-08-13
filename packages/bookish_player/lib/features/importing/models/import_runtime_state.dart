import '../../../core/foundation/clock.dart';
import 'import_progress.dart';
import 'import_stage.dart';
import 'import_workflow_failure.dart';
import 'source_removal_exception.dart';

class ImportRuntimeState {
  ImportRuntimeState(this._clock);

  final Clock _clock;
  final pendingPaths = <String>{};
  final _stageHistory = <String>[];
  ImportStage _stage = ImportStage.selectingFiles;
  String? _activeFile;
  List<String> _parserDiagnostics = const [];
  DateTime? _stageStartedAt;

  void trackProgress(ImportProgressCallback callback, ImportProgress progress) {
    final now = _clock.now();
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

  void recordParserDiagnostics(List<String> diagnostics) {
    _parserDiagnostics = diagnostics;
  }

  ImportWorkflowFailure buildFailure(Object error, StackTrace stackTrace) =>
      ImportWorkflowFailure(
        error: error,
        stackTrace: stackTrace,
        stage: _stage,
        activeFile: _activeFile,
        parserDiagnostics: _parserDiagnostics,
        stageHistory: _buildCompletedStageHistory(),
        originalRemovalOnly: error is SourceRemovalException,
      );

  List<String> _buildCompletedStageHistory() {
    final result = [..._stageHistory];
    if (_stageStartedAt case final started?) {
      result.add(
        '${_stage.name} before failure: ${_clock.now().difference(started).inMilliseconds} ms',
      );
    }
    return result;
  }
}
