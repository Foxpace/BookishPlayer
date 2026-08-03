import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/file_import_repository.dart';

part 'import_progress.freezed.dart';

enum ImportStage {
  selectingFiles,
  copyingFile,
  readingDuration,
  analyzingChapters,
  extractingArtwork,
  savingBook,
  removingOriginals,
}

@freezed
abstract class ImportProgress with _$ImportProgress {
  const factory ImportProgress({
    required ImportStage stage,
    SelectedAudioFile? selected,
    @Default(0) int index,
    @Default(0) int total,
    String? title,
    int? copiedBytes,
    int? totalBytes,
  }) = _ImportProgress;
}

@freezed
abstract class ImportResult with _$ImportResult {
  const factory ImportResult({
    required List<SelectedAudioFile> selectedFiles,
    required int importedCount,
  }) = _ImportResult;
}

@freezed
abstract class ImportWorkflowFailure
    with _$ImportWorkflowFailure
    implements Exception {
  const factory ImportWorkflowFailure({
    required Object error,
    required StackTrace stackTrace,
    required ImportStage stage,
    required List<String> stageHistory,
    String? activeFile,
    @Default(<String>[]) List<String> parserDiagnostics,
    @Default(false) bool originalRemovalOnly,
  }) = _ImportWorkflowFailure;
}

class SourceRemovalException implements Exception {
  const SourceRemovalException(this.cause);

  final Object cause;

  @override
  String toString() => '$cause';
}
