import 'package:freezed_annotation/freezed_annotation.dart';

import '../application/import_progress.dart';

part 'import_state.freezed.dart';

enum ImportStatus { picking, importing, complete, cancelled, failure }

@freezed
abstract class ImportState with _$ImportState {
  const factory ImportState({
    @Default(ImportStatus.picking) ImportStatus status,
    @Default(ImportStage.selectingFiles) ImportStage stage,
    @Default(0) int importedCount,
    @Default(0) int totalFiles,
    String? currentTitle,
    @Default('Opening file browser') String heading,
    @Default('Choose one or more audiobook files.') String detail,
    double? progress,
    String? diagnostics,
  }) = _ImportState;
}
